-- Drop primary, unique and foreign key constraints 
alter table T_GRUPOS
  drop constraint FK_GRUPOS_TORNEOS;
-- Add/modify columns 
alter table T_GRUPOS rename column id_torneo to ID_DIVISION;
