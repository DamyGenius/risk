-- Add/modify columns 
alter table T_TORNEOS rename column por_fases to TIPO;
alter table T_TORNEOS modify tipo default 'L';
-- Add comments to the columns 
comment on column T_TORNEOS.tipo
  is 'Tipo de torneo. (L-Liga, C-Copa)';
