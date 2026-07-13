prompt Ampliando atributos de Y_SESION...
alter type Y_SESION
  modify attribute
  (
    access_token VARCHAR2(4000),
    refresh_token VARCHAR2(4000)
  )
  cascade;
prompt Done.
