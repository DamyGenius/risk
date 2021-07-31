-- Add/modify columns 
alter table T_PARTIDOS add estado_juego VARCHAR2(2);
-- Add comments to the columns 
comment on column T_PARTIDOS.estado_juego
  is 'PT - Primer Tiempo, ET - Entretiempo, ST - Segundo Tiempo';
