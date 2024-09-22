/*
 Caso deseje-se manter a tabela Turma atualizada para remoções, inserções e atualizaçãos.
*/

CREATE OR REPLACE FUNCTION update_turma RETURNS trigger 
  AS $update_turma$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    UPDATE Turma SET NAlunos = NAlunos - 1 
    WHERE Sigla = old.Sigla AND Letra = old.Letra;
  IF (TG_OP = 'INSERT') THEN
    UPDATE Turma SET NAlunos = NAlunos + 1
    WHERE Sigla = new.Sigla AND Letra = new.Letra;
  IF (TG_OP = 'UPDATE') THEN
    IF ((NEW.SIGLA <> OLD.SIGLA) || (NEW.LETRA <> OLD.LETRA)) THEN
      UPDATE Turma SET Nalunos = NAlunos - 1
      WHERE Sigla = old.Sigla AND Letra = old.Letra;
      UPDATE Turma SET NAlunos = NAlunos + 1 
      WHERE Sigla = new.Sigla AND Letra = new.Letra;
    END IF;
  END IF;
  RETURN NULL;
END;
$update_turma$ LANGUAGE plpgsql;

DROP TRIGGER NroDeAlunos ON Matricula;

CREATE TRIGGER NroDeAlunos
  AFTER DELETE OR UPDATE OR INSERT ON Matricula
  FOR EACH ROW EXECUTE PROCEDURE update_turma();