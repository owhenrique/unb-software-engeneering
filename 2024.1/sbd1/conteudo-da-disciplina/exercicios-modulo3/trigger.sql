/*
Deseja-se manter a tabela Turma atualizada de acordo com as remoções ocorridas na tabela Matrícula
*/

CREATE OR REPLACE FUNCTION update_turma() RETURNS trigger 
  AS $update_turma$ /* Valor que o SGBD vai usar para referenciar essa função */
BEGIN
  UPDATE Turma SET NAlunos = Nalunos - 1 WHERE Sigla = old.sigla AND Letra = old.Letra;
  RETURN NULL;
END;
$update_turma$ LANGUAGE plpgsql;

CREATE TRIGGER NroDeAlunos
  AFTER DELETE ON Matricula
  FOR EACH ROW EXECUTE PROCEDURE update_turma();