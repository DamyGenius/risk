ALTER TABLE T_PARTIDOS ADD (
  contexto_previo       CLOB,
  fecha_ultimo_contexto TIMESTAMP(0) WITH TIME ZONE
);

comment on column T_PARTIDOS.contexto_previo
  is 'Contexto previo del partido generado por IA';
comment on column T_PARTIDOS.fecha_ultimo_contexto
  is 'Fecha de ultima consulta del contexto previo';
