prompt Ampliando campos de T_SESIONES...
alter table T_SESIONES modify access_token VARCHAR2(4000);
alter table T_SESIONES modify refresh_token VARCHAR2(4000);
alter table T_SESIONES modify direccion_ip VARCHAR2(300);
alter table T_SESIONES modify host VARCHAR2(300);
alter table T_SESIONES modify terminal VARCHAR2(300);
alter table T_SESIONES modify dato_externo VARCHAR2(4000);
prompt Done.
