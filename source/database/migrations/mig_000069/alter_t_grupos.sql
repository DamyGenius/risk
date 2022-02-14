-- Drop primary, unique and foreign key constraints 
alter table T_GRUPOS
  drop constraint FK_GRUPOS_TORNEO_JORNADAS;
-- Drop columns 
alter table T_GRUPOS drop column id_jornada_inicio;
alter table T_GRUPOS drop column id_jornada_fin;
