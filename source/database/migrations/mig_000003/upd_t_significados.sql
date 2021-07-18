UPDATE t_significados s
   SET s.significado = '0'
 WHERE s.dominio = 'POLITICA_VALIDACION_CLAVE_ACCESO'
   AND s.codigo IN ('CAN_MIN_CARACTERES_ESPECIALES',
                    'CAN_MIN_LETRAS_ABECEDARIO',
                    'CAN_MIN_MAYUSCULAS',
                    'CAN_MIN_MINUSCULAS');

UPDATE t_significados s
   SET s.significado = '6'
 WHERE s.dominio = 'POLITICA_VALIDACION_CLAVE_ACCESO'
   AND s.codigo IN ('LONGITUD_MINIMA', 'CAN_MAX_CARACTERES_IGUALES');
