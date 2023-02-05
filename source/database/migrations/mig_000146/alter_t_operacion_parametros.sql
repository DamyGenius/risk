-- Add/modify columns 
alter table T_OPERACION_PARAMETROS add tipo_parametro VARCHAR2(20);
-- Add comments to the columns 
comment on column T_OPERACION_PARAMETROS.tipo_parametro
  is 'Tipo de parámetro del servicio';
-- Create/Recreate check constraints 
alter table T_OPERACION_PARAMETROS
  add constraint CK_OPE_PAR_TIPO_PARAMETRO
  check (TIPO_PARAMETRO IN ('BODY', 'QUERY'));
