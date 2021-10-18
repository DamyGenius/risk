-- Add/modify columns 
alter table T_TORNEOS add prueba VARCHAR2(1);
alter table T_TORNEOS modify prueba default 'N';
-- Add comments to the columns 
comment on column T_TORNEOS.prueba
  is '¿Es torneo de prueba?';
