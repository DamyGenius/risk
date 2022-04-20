-- Add/modify columns 
alter table T_PARTIDOS add id_fase NUMBER(3);
alter table T_PARTIDOS add id_grupo NUMBER(3);
alter table T_PARTIDOS add descripcion VARCHAR2(50);
alter table T_PARTIDOS add nombre_club_local VARCHAR2(100);
alter table T_PARTIDOS add nombre_club_visitante VARCHAR2(100);
-- Add comments to the columns 
comment on column T_PARTIDOS.id_fase
  is 'Identificador de la Fase';
comment on column T_PARTIDOS.id_grupo
  is 'Identificador del Grupo';
comment on column T_PARTIDOS.descripcion
  is 'Descripción del Partido';
comment on column T_PARTIDOS.nombre_club_local
  is 'Nombre del club local';
comment on column T_PARTIDOS.nombre_club_visitante
  is 'Nombre del club visitante';
-- Create/Recreate primary, unique and foreign key constraints 
alter table T_PARTIDOS
  add constraint FK_PARTIDOS_TORNEO_FASES foreign key (ID_TORNEO, ID_FASE)
  references T_TORNEO_FASES (ID_TORNEO, ID_FASE);
alter table T_PARTIDOS
  add constraint FK_PARTIDOS_TORNEO_GRUPOS foreign key (ID_TORNEO, ID_FASE, ID_GRUPO)
  references T_TORNEO_GRUPOS (ID_TORNEO, ID_FASE, ID_GRUPO);
