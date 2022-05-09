-- Add/modify columns 
alter table T_TORNEOS add por_fases VARCHAR2(1) default 'N';
alter table T_TORNEOS add importado VARCHAR2(1) default 'N';
-- Add comments to the columns 
comment on column T_TORNEOS.actual
  is '¿Es torneo actual?';
comment on column T_TORNEOS.por_fases
  is '¿El torneo es por fases?';
comment on column T_TORNEOS.importado
  is '¿El torneo ingresa al proceso de importación?';
