-- Add/modify columns 
alter table T_PARTIDOS add tiempo_juego VARCHAR2(10);
-- Add comments to the columns 
comment on column T_PARTIDOS.tiempo_juego
  is 'Tiempo de juego';
