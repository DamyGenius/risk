CREATE OR REPLACE PACKAGE test_k_util IS

  --%suite(Tests unitarios del paquete k_util)
  --%tags(package)

  --%context(Tests unitarios de f_formatear_titulo)
  --%name(f_formatear_titulo)

  --%test(Formateo b�sico de t�tulo)
  PROCEDURE f_formatear_titulo_uso_basico;
  --%endcontext

END;
/
CREATE OR REPLACE PACKAGE BODY test_k_util IS

  PROCEDURE f_formatear_titulo_uso_basico IS
  BEGIN
    ut.expect(k_util.f_formatear_titulo('ESte eS UN t�tULO DE pruEba')).to_equal('Este Es Un T�tulo de Prueba');
  END;

END;
/
