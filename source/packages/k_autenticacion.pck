CREATE OR REPLACE PACKAGE k_autenticacion IS

  -- Agrupa operaciones relacionadas con la autenticacion de usuarios
  --
  -- %author jmeza 11/3/2019 23:24:54

  PROCEDURE p_registrar_usuario(i_usuario IN VARCHAR2,
                                i_clave   IN VARCHAR2);

  PROCEDURE p_cambiar_clave(i_usuario       IN VARCHAR2,
                            i_clave_antigua IN VARCHAR2,
                            i_clave_nueva   IN VARCHAR2);

  FUNCTION f_validar_credenciales(i_usuario IN VARCHAR2,
                                  i_clave   IN VARCHAR2) RETURN BOOLEAN;

  PROCEDURE p_validar_credenciales(i_usuario IN VARCHAR2,
                                   i_clave   IN VARCHAR2);

  PROCEDURE p_iniciar_sesion(i_usuario IN VARCHAR2,
                             i_token   IN VARCHAR2);

  PROCEDURE p_finalizar_sesion(i_id_sesion IN NUMBER);
END;
/

CREATE OR REPLACE PACKAGE BODY k_autenticacion IS

  c_algoritmo      CONSTANT PLS_INTEGER := sys.dbms_crypto.hmac_sh1;
  c_iteraciones    CONSTANT PLS_INTEGER := 4096;
  c_longitud_bytes CONSTANT PLS_INTEGER := 32;

  c_clave_acceso CONSTANT CHAR(1) := 'A';

  cantidad_intentos_permitidos CONSTANT PLS_INTEGER := 3;

  -- Excepciones
  ex_credenciales_invalidas EXCEPTION;
  ex_usuario_inexistente    EXCEPTION;

  -- https://mikepargeter.wordpress.com/2012/11/26/pbkdf2-in-oracle
  -- https://www.ietf.org/rfc/rfc6070.txt
  FUNCTION pbkdf2(p_password   IN VARCHAR2,
                  p_salt       IN VARCHAR2,
                  p_count      IN INTEGER,
                  p_key_length IN INTEGER) RETURN VARCHAR2 IS
    l_block_count INTEGER;
    l_last        RAW(32767);
    l_xorsum      RAW(32767);
    l_result      RAW(32767);
  BEGIN
    -- SHA-1   ==> 20 bytes
    -- SHA-256 ==> 32 bytes
    l_block_count := ceil(p_key_length / 20);
    FOR i IN 1 .. l_block_count LOOP
      l_last   := utl_raw.concat(utl_raw.cast_to_raw(p_salt),
                                 utl_raw.cast_from_binary_integer(i,
                                                                  utl_raw.big_endian));
      l_xorsum := NULL;
      FOR j IN 1 .. p_count LOOP
        l_last := sys.dbms_crypto.mac(l_last,
                                      c_algoritmo,
                                      utl_raw.cast_to_raw(p_password));
        IF l_xorsum IS NULL THEN
          l_xorsum := l_last;
        ELSE
          l_xorsum := utl_raw.bit_xor(l_xorsum, l_last);
        END IF;
      END LOOP;
      l_result := utl_raw.concat(l_result, l_xorsum);
    END LOOP;
    RETURN rawtohex(utl_raw.substr(l_result, 1, p_key_length));
  END;

  FUNCTION lf_id_usuario(i_alias IN VARCHAR2) RETURN NUMBER IS
    l_id_usuario t_usuarios.id_usuario%TYPE;
  BEGIN
    BEGIN
      SELECT id_usuario
        INTO l_id_usuario
        FROM t_usuarios
       WHERE alias = i_alias;
    EXCEPTION
      WHEN no_data_found THEN
        l_id_usuario := NULL;
      WHEN OTHERS THEN
        l_id_usuario := NULL;
    END;
    RETURN l_id_usuario;
  END;

  PROCEDURE lp_registrar_intento_fallido(i_id_usuario IN NUMBER,
                                         i_tipo       IN CHAR) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE t_usuario_claves
       SET cantidad_intentos_fallidos = CASE
                                          WHEN nvl(cantidad_intentos_fallidos,
                                                   0) >=
                                               cantidad_intentos_permitidos THEN
                                           cantidad_intentos_fallidos
                                          ELSE
                                           nvl(cantidad_intentos_fallidos, 0) + 1
                                        END,
           estado = CASE
                      WHEN nvl(cantidad_intentos_fallidos, 0) >=
                           cantidad_intentos_permitidos THEN
                       'B'
                      ELSE
                       estado
                    END
     WHERE id_usuario = i_id_usuario
       AND tipo = i_tipo;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END;

  PROCEDURE lp_registrar_autenticacion(i_id_usuario IN NUMBER,
                                       i_tipo       IN CHAR) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    UPDATE t_usuario_claves
       SET cantidad_intentos_fallidos = 0,
           fecha_ultima_autenticacion = SYSDATE
     WHERE id_usuario = i_id_usuario
       AND tipo = i_tipo;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END;

  PROCEDURE p_registrar_usuario(i_usuario IN VARCHAR2,
                                i_clave   IN VARCHAR2) IS
    l_id_usuario t_usuarios.id_usuario%TYPE;
    l_hash       t_usuario_claves.hash%TYPE;
    l_salt       t_usuario_claves.salt%TYPE;
  BEGIN
    -- Genera salt
    l_salt := rawtohex(sys.dbms_crypto.randombytes(c_longitud_bytes));
    -- Genera hash
    l_hash := pbkdf2(i_clave, l_salt, c_iteraciones, c_longitud_bytes);
  
    -- Inserta usuario
    INSERT INTO t_usuarios
      (alias, estado)
    VALUES
      (i_usuario, 'A')
    RETURNING id_usuario INTO l_id_usuario;
  
    -- Inserta clave de usuario
    INSERT INTO t_usuario_claves c
      (id_usuario,
       tipo,
       estado,
       HASH,
       salt,
       algoritmo,
       iteraciones,
       cantidad_intentos_fallidos,
       fecha_ultima_autenticacion)
    VALUES
      (l_id_usuario,
       c_clave_acceso,
       'A',
       l_hash,
       l_salt,
       c_algoritmo,
       c_iteraciones,
       0,
       SYSDATE);
  END;

  PROCEDURE p_cambiar_clave(i_usuario       IN VARCHAR2,
                            i_clave_antigua IN VARCHAR2,
                            i_clave_nueva   IN VARCHAR2) IS
    l_id_usuario t_usuarios.id_usuario%TYPE;
    l_hash       t_usuario_claves.hash%TYPE;
    l_salt       t_usuario_claves.salt%TYPE;
  BEGIN
    -- Busca usuario
    l_id_usuario := lf_id_usuario(i_usuario);
  
    IF l_id_usuario IS NULL THEN
      RAISE ex_usuario_inexistente;
    END IF;
  
    IF NOT f_validar_credenciales(i_usuario, i_clave_antigua) THEN
      RAISE ex_credenciales_invalidas;
    END IF;
  
    -- Genera salt
    l_salt := rawtohex(sys.dbms_crypto.randombytes(c_longitud_bytes));
    -- Genera hash
    l_hash := pbkdf2(i_clave_nueva, l_salt, c_iteraciones, c_longitud_bytes);
  
    -- Actualiza clave de usuario
    UPDATE t_usuario_claves
       SET HASH                       = l_hash,
           salt                       = l_salt,
           algoritmo                  = c_algoritmo,
           iteraciones                = c_iteraciones,
           cantidad_intentos_fallidos = 0,
           fecha_ultima_autenticacion = SYSDATE
     WHERE id_usuario = l_id_usuario
       AND tipo = c_clave_acceso
       AND estado = 'A';
    IF SQL%NOTFOUND THEN
      RAISE ex_credenciales_invalidas;
    END IF;
  EXCEPTION
    WHEN ex_usuario_inexistente THEN
      raise_application_error(-20000, 'Credenciales invalidas');
    WHEN ex_credenciales_invalidas THEN
      lp_registrar_intento_fallido(l_id_usuario, c_clave_acceso);
      raise_application_error(-20000, 'Credenciales invalidas');
    WHEN OTHERS THEN
      lp_registrar_intento_fallido(l_id_usuario, c_clave_acceso);
      raise_application_error(-20000, 'Credenciales invalidas');
  END;

  FUNCTION f_validar_credenciales(i_usuario IN VARCHAR2,
                                  i_clave   IN VARCHAR2) RETURN BOOLEAN IS
    l_id_usuario  t_usuarios.id_usuario%TYPE;
    l_hash        t_usuario_claves.hash%TYPE;
    l_salt        t_usuario_claves.salt%TYPE;
    l_iteraciones t_usuario_claves.iteraciones%TYPE;
  BEGIN
    -- Busca usuario
    l_id_usuario := lf_id_usuario(i_usuario);
  
    IF l_id_usuario IS NULL THEN
      RAISE ex_usuario_inexistente;
    END IF;
  
    BEGIN
      SELECT c.hash, c.salt, c.iteraciones
        INTO l_hash, l_salt, l_iteraciones
        FROM t_usuario_claves c
       WHERE c.id_usuario = l_id_usuario
         AND c.tipo = c_clave_acceso
         AND c.estado = 'A';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE ex_credenciales_invalidas;
    END;
  
    IF l_hash <> pbkdf2(i_clave,
                        l_salt,
                        l_iteraciones,
                        utl_raw.length(hextoraw(l_hash))) THEN
      RAISE ex_credenciales_invalidas;
    END IF;
  
    lp_registrar_autenticacion(l_id_usuario, c_clave_acceso);
    RETURN TRUE;
  EXCEPTION
    WHEN ex_usuario_inexistente THEN
      RETURN FALSE;
    WHEN ex_credenciales_invalidas THEN
      lp_registrar_intento_fallido(l_id_usuario, c_clave_acceso);
      RETURN FALSE;
    WHEN OTHERS THEN
      lp_registrar_intento_fallido(l_id_usuario, c_clave_acceso);
      RETURN FALSE;
  END;

  PROCEDURE p_validar_credenciales(i_usuario IN VARCHAR2,
                                   i_clave   IN VARCHAR2) IS
  BEGIN
    IF NOT f_validar_credenciales(i_usuario, i_clave) THEN
      raise_application_error(-20000, 'Credenciales invalidas');
    END IF;
  END;

  PROCEDURE p_iniciar_sesion(i_usuario IN VARCHAR2,
                             i_token   IN VARCHAR2) IS
    l_id_usuario t_usuarios.id_usuario%TYPE;
    l_cantidad   NUMBER(3);
  BEGIN
    -- Busca usuario
    l_id_usuario := lf_id_usuario(i_usuario);
  
    IF l_id_usuario IS NULL THEN
      RAISE ex_usuario_inexistente;
    END IF;
  
    -- Obtiene cantidad de sesiones del usuario
    SELECT COUNT(id_sesion)
      INTO l_cantidad
      FROM t_sesiones
     WHERE estado = 'A'
       AND id_usuario = l_id_usuario;
  
    IF l_cantidad > 0 THEN
      raise_application_error(-20000, 'Usuario tiene una sesion activa');
    END IF;
  
    -- Inserta sesion
    INSERT INTO t_sesiones
      (token,
       estado,
       id_aplicacion,
       fecha_autenticacion,
       fecha_expiracion,
       id_usuario,
       direccion_ip,
       host,
       terminal)
    VALUES
      (i_token,
       'A',
       NULL,
       SYSDATE,
       NULL,
       l_id_usuario,
       k_util.f_direccion_ip,
       k_util.f_host,
       k_util.f_terminal);
  EXCEPTION
    WHEN ex_usuario_inexistente THEN
      raise_application_error(-20000, 'Usuario inexistente');
  END;

  PROCEDURE p_finalizar_sesion(i_id_sesion IN NUMBER) IS
  BEGIN
    UPDATE t_sesiones SET estado = 'F' WHERE id_sesion = i_id_sesion;
  END;

BEGIN
  -- Initialization
  NULL;
END;
/

