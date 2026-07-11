-- Add/modify columns 
alter table T_TORNEOS add incluir_alineaciones VARCHAR2(1) default 'N' not null;
alter table T_TORNEOS add incluir_incidencias VARCHAR2(1) default 'N' not null;
-- Add comments to the columns 
comment on column T_TORNEOS.incluir_alineaciones
  is '¿El torneo incluye alineaciones del partido en el proceso de importación? (S/N)';
comment on column T_TORNEOS.incluir_incidencias
  is '¿El torneo incluye incidencias del partido en el proceso de importación? (S/N)';
