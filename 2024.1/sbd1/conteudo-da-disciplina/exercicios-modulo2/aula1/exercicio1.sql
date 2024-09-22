CREATE TABLE Aluno 
(
	nome 				    varchar(255),
	matricula			  varchar(9),
	idade 				  integer			NOT NULL,
	data_nascimento	varchar(8)	NOT NULL,

	PRIMARY KEY(matricula),
	UNIQUE(nome)
);

CREATE TABLE Professor
(
	nome 		  varchar(255),
	matricula varchar(9),
	idade 		integer 		NOT NULL,
	titulacao	varchar(3)	NOT NULL,

	PRIMARY KEY(matricula),
	UNIQUE(nome),
	CHECK(titulacao = 'Msc' OR  titulacao = 'Dr' OR titulacao = 'Phd')
);

CREATE TABLE Disciplina
(
	Sigla		  VARCHAR(7),
	nome		  VARCHAR(50),
	creditos	INTEGER		NOT NULL,
	professor	VARCHAR(9),
	livro		  VARCHAR(50) DEFAULT NULL,


	PRIMARY KEY(sigla),
	FOREIGN KEY(professor) REFERENCES Professor(matricula) ON DELETE RESTRICT
	
);

CREATE TABLE Turma
(	
	sigla			    VARCHAR(7),
	numero			  INTEGER	NOT NULL,
	numero_alunos	INTEGER		NOT NULL,

  CONSTRAINT turma_pk
	  PRIMARY KEY(sigla, numero),
  FOREIGN KEY(sigla) REFERENCES Disciplina(sigla) ON DELETE RESTRICT
);

CREATE TABLE Matricula
(
	sigla		  VARCHAR(7),
	numero    INTEGER,
	aluno		  VARCHAR(255),
	ano			  INTEGER,
	semestre	INTEGER,	
	nota		  CHAR(2),
  
  CONSTRAINT matricula_pk
	  PRIMARY KEY(sigla, numero, aluno, ano, semestre),
  CONSTRAINT matricula_sigla_numero_fk
	  FOREIGN KEY(sigla, numero) 		REFERENCES Turma(sigla, numero) ON DELETE RESTRICT,
	FOREIGN KEY(aluno) 		        REFERENCES Aluno(matricula) 		ON DELETE RESTRICT,

	CHECK(semestre = 1 OR semestre = 2),
	CHECK(nota = 'SR' OR nota = 'II' OR nota = 'MI' OR nota = 'MM' OR nota = 'MS' OR nota = 'SS')
);