-- Add/modify columns 
alter table T_GRUPO_TORNEOS add id_fase_inicio NUMBER(3);
alter table T_GRUPO_TORNEOS add id_fase_fin NUMBER(3);
alter table T_GRUPO_TORNEOS add id_grupo_base number;
-- Add comments to the columns 
comment on column T_GRUPO_TORNEOS.id_grupo
  is 'Identificador del grupo';
comment on column T_GRUPO_TORNEOS.id_torneo
  is 'Identificador de torneo';
comment on column T_GRUPO_TORNEOS.id_jornada_inicio
  is 'Identificador de la jornada inicial';
comment on column T_GRUPO_TORNEOS.id_jornada_fin
  is 'Identificador de la jornada final';
comment on column T_GRUPO_TORNEOS.id_fase_inicio
  is 'Identificador de la fase inicial';
comment on column T_GRUPO_TORNEOS.id_fase_fin
  is 'Identificador de la fase final';
comment on column T_GRUPO_TORNEOS.id_grupo_base
  is 'Identificador del grupo base';
