CREATE DATABASE Empresa;

USE Empresa;

CREATE TABLE Empresa.Funcionario(
   Pnome VARCHAR(15) NOT NULL,
   Minicial CHAR,
   Unome VARCHAR(15) NOT NULL,
   Cpf CHAR(11),
   DataNasc DATE,
   Endereco VARCHAR(255),
   Sexo CHAR,
   Salario DECIMAL(10,2),
   Cpf_supervisor CHAR(11),
   Dnr INT,
   PRIMARY KEY(Cpf),
   FOREIGN KEY(Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);

CREATE TABLE Empresa.Departamento(
    Dnome VARCHAR(15),
    Dnumero INT,
    PRIMARY KEY(Dnumero),
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
	FOREIGN KEY(Cpf_gerente) REFERENCES FUNCIONARIO(Cpf)
);


CREATE TABLE Empresa.Projeto(
Projnome VARCHAR(45),
Projnumero INT,
PRIMARY KEY(Projnumero),
Projlocal VARCHAR(45),
Dnumero INT,
FOREIGN KEY(Dnumero) REFERENCES Departamento(Dnumero)
);

CREATE TABLE Empresa.Dependente(
Cpf CHAR(11),
FOREIGN KEY(Cpf) REFERENCES Funcionario(Cpf),
Nome_Dependente VARCHAR(45),
PRIMARY KEY(Nome_Dependente),
Sexo VARCHAR(10),
DataNasc DATE,
Parentesco VARCHAR(45)
);

CREATE TABLE Empresa.Trabalha_em(
Cpf CHAR(11),
FOREIGN KEY(Cpf) REFERENCES Funcionario(Cpf),
Projnumero INT,
FOREIGN KEY(Projnumero) REFERENCES Projeto(Projnumero),
PRIMARY KEY (Projnumero, Cpf),
Hora TIME
);

CREATE TABLE IF NOT EXISTS Empresa.Localização_Dep(
  Dnumero INT NOT NULL,
  FOREIGN KEY(Dnumero) REFERENCES Projeto(Dnumero),
  Dlocal VARCHAR(45) NOT NULL,
  PRIMARY KEY (Dnumero, Dlocal)
  );
