#Deletar miha DATABASE
DROP DATABASE Empresa;

#Cirando minha DATABASE
CREATE DATABASE IF NOT EXISTS Empresa;

#Criando minhas tabelas
CREATE TABLE Empresa.Funcionario(
   Pnome VARCHAR(15) NOT NULL,
   Minicial CHAR,
   Unome VARCHAR(15) NOT NULL,
   Cpf CHAR(11) PRIMARY KEY,
   DataNasc DATE,
   Endereco VARCHAR(255),
   Sexo CHAR,
   Salario DECIMAL(10,2),
   Cpf_supervisor CHAR(11),
   Dnr INT,
   FOREIGN KEY(Cpf_supervisor) REFERENCES Funcionario(Cpf)
);

#Verficar informações da tabela criada
DESC Empresa.Funcionario;

CREATE TABLE Empresa.Departamento(
    Dnome VARCHAR(15),
    Dnumero INT,
    PRIMARY KEY(Dnumero),
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    UNIQUE (Dnome),
	FOREIGN KEY(Cpf_gerente) REFERENCES Funcionario(Cpf)
);

#Adicionando restrição referencial em FUNCIONARIO de DEPARTAMENTO
#Criando alteração
ALTER  TABLE Empresa.Funcionario
ADD CONSTRAINT Dnr
FOREIGN KEY(Dnr) REFERENCES Departamento(Dnumero);

CREATE TABLE IF NOT EXISTS Empresa.Localização_Dep(
  Dnum INT NOT NULL,
  Dlocal VARCHAR(45) NOT NULL,
  PRIMARY KEY (Dnum, Dlocal)
  );

CREATE TABLE Empresa.Projeto(
Projnome VARCHAR(15) NOT NULL,
Projnumero INT,
PRIMARY KEY(Projnumero),
Projlocal VARCHAR(15),
Dnum INT,
UNIQUE (Projnumero)
);

CREATE TABLE Empresa.Trabalha_em(
cpf CHAR(11) NOT NULL,
Pnr INT NOT NULL,
FOREIGN KEY(Cpf) REFERENCES Funcionario(Cpf),
Projnumero INT,
FOREIGN KEY(Projnumero) REFERENCES Projeto(Projnumero),
PRIMARY KEY (Projnumero, cpf),
Hora DECIMAL(3,1) NOT NULL
);

#Selecionar a DATABASE para execução de comandos
USE Empresa;

#Criando tabela dependente sem seleção do esquema
CREATE TABLE Dependente(
Cpf CHAR(11),
FOREIGN KEY(Cpf) REFERENCES Funcionario(Cpf),
Nome_Dependente VARCHAR(45),
PRIMARY KEY(Nome_Dependente),
Sexo VARCHAR(10),
DataNasc DATE,
Parentesco VARCHAR(45)
);

#Acrescentar restrição CHECK TABLE
ALTER TABLE Funcionario
ADD CONSTRAINT Salario
CHECK (Salario > 0);

#Inserindo valores na tabela Departamento
INSERT INTO Departamento (Dnome, Dnumero)
VALUES ('Pesquisa', 5);

#Recuperando todos os registros de 
SELECT * FROM Departamento




