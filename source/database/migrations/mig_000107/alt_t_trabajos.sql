-- Add/modify columns 
alter table T_TRABAJOS add programa VARCHAR2(128);
-- Add comments to the columns 
comment on column T_TRABAJOS.programa
  is 'Programa del trabajo';
