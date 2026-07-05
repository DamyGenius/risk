prompt Importing table t_migraciones...
set feedback off
set define off
insert into t_migraciones (ID_MIGRACION, DESCRIPCION)
values ('mig_000156', 'Optimizar cache de prompts de OpenAI para previa de partidos.');

prompt Done.
