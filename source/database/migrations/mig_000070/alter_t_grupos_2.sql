-- Add/modify columns 
alter table T_GRUPOS modify id_division VARCHAR2(3);
-- Create primary, unique and foreign key constraints 
alter table T_GRUPOS
  add constraint FK_GRUPOS_DIVISIONES foreign key (ID_DIVISION)
  references T_DIVISIONES (ID_DIVISION);
