#Criando meu primiero banco
CREATE DATABASE EMPRESA;

#Usar o banco criado
USE EMPRESA;

#Criando nossa primeira tabela
CREATE TABLE EMPRESA.FUNCIONARIO(
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

CREATE TABLE EMPRESA.DEPARTAMENTO(
    Dnome VARCHAR(15),
    Dnumero INT,
    PRIMARY KEY(Dnumero),
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    UNIQUE (Dnome),
	FOREIGN KEY(Cpf_gerente) REFERENCES FUNCIONARIO(Cpf)
);
