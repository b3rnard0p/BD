CREATE DATABASE IF NOT EXISTS EMPRESA;
#Criação da tabela FUNCIONARIO
CREATE TABLE EMPRESA.FUNCIONARIO (
	Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11),
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR,
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    PRIMARY KEY (Cpf),
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);

#Tablea de DEPARTAMENTO
CREATE TABLE EMPRESA.DEPARTAMENTO (
	Dnome VARCHAR(15) NOT NULL,
    Dnumero INT,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    PRIMARY KEY (Dnumero),
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(CPF)
);

#Adiconando restição referencial em FUNCIONARO de DEPARTAMENTO
#Criando uma ALTERAÇÃO de Tabela
ALTER TABLE EMPRESA.FUNCIONARIO
ADD CONSTRAINT Dnr
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO (Dnumero);

#Criação da tabela de LOCALIZACAO_DEP
CREATE TABLE EMPRESA.LOCALIZACAO_DEP (
	Dnumero INT NOT NULL,
	Dlocal VARCHAR (15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO (Dnumero)
);

#Criacao da tabela PROJETO
CREATE TABLE EMPRESA.PROJETO(
	Projnome VARCHAR (15) NOT NULL,
	Projnumero INT NOT NULL,
    Projlocal VARCHAR(15),
    Dnum INT,
    PRIMARY KEY (Projnumero),
    UNIQUE (Projnome),
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO (Dnumero)
);

#Criação da tabela TRABALHA_EM
CREATE TABLE EMPRESA.TRABALHA_EM(
	Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL (3,1) NOT NULL,
    PRIMARy KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO (Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);

#Selecionando o esquema para criação da tabela
USE EMPRESA;
#Criação da tabela DEPENDENTE sem seleção do esquema
CREATE TABLE DEPENDENTE(
	Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR,
    Datanasc DATE,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);

#Inserindo valores no Departamento
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Pesquisa', 5);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Administração', 4);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Matriz', 1);
SELECT * FROM DEPARTAMENTO;
#Inserindo funcionarios com cargo de gerencia DATE AAAA-MM-DD
INSERT INTO FUNCIONARIO VALUES ( 'Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL , 1 );
INSERT INTO FUNCIONARIO VALUES ( 'Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, '88866555576' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'André', 'E', 'Brito', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, '98765432168' , 4 );

#Corrigindo erro de inserção
UPDATE FUNCIONARIO
SET Endereco = 'Rua Reboucas, 65, Piracicaba, SP'
WHERE Cpf = '66688444476';
#Recupera todas as informações de funcionários
SELECT * FROM FUNCIONARIO;

#Finzalindo o preenchimento da tabela DEPTARTAMENTO
UPDATE DEPARTAMENTO
SET Cpf_gerente = '33344555587', Data_inicio_gerente = '1988-05-22'
WHERE Dnumero = 5;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '98765432168', Data_inicio_gerente = '1995-01-01'
WHERE Dnumero = 4;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
#Recuperar todas as informações de departamento
SELECT * FROM DEPARTAMENTO;

#Prrencher a tabela LOCALIZACAO_DEP
INSERT INTO LOCALIZACAO_DEP VALUES (1, 'São Paulo');
INSERT INTO LOCALIZACAO_DEP VALUES (4, 'Mauá');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Santo André');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Itu');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'São Paulo');
#Recuperando informações de LOCALIZACAO_DEP
SELECT * FROM LOCALIZACAO_DEP;

#Preenchendo a table PROJETO
INSERT INTO PROJETO VALUES ('ProdutoX', 1, 'Santo André', 5);
INSERT INTO PROJETO VALUES ('ProdutoY', 2, 'Itu', 5);
INSERT INTO PROJETO VALUES ('ProdutoZ', 3, 'São Paulo', 5);
INSERT INTO PROJETO VALUES ('Informatização', 10, 'Mauá', 4);
INSERT INTO PROJETO VALUES ('Reorganização', 20, 'São Paulo', 1);
INSERT INTO PROJETO VALUES ('Novosbenefícios', 30, 'Mauá', 4);
#Recuperando informações de PROJETO
SELECT * FROM PROJETO;

#Preenchento TRABALHA_EM
INSERT INTO TRABALHA_EM VALUES ('12345678966',1,32.5);
INSERT INTO TRABALHA_EM VALUES ('12345678966',2,7.5);
INSERT INTO TRABALHA_EM VALUES ('66688444476',3,40);
INSERT INTO TRABALHA_EM VALUES ('45345345376',1,20);
INSERT INTO TRABALHA_EM VALUES ('45345345376',2,20);
INSERT INTO TRABALHA_EM VALUES ('33344555587',2,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',3,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',10,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',20,10);
INSERT INTO TRABALHA_EM VALUES ('99988777767',10,10);
INSERT INTO TRABALHA_EM VALUES ('99988777767',30,30);
INSERT INTO TRABALHA_EM VALUES ('98798798733',10,35);
INSERT INTO TRABALHA_EM VALUES ('98798798733',30,5);
INSERT INTO TRABALHA_EM VALUES ('98765432168',30,20);
INSERT INTO TRABALHA_EM VALUES ('98765432168',20,15);

#Preenchendo a tabela de DEPENDENTES
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filh0');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Janaina', 'F', '1958-05-03', 'Eposa');
INSERT INTO DEPENDENTE VALUES ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

SELECT DISTINCT Salario
FROM EMPRESA.Funcionario
ORDER BY Salario ASC;

SELECT *
FROM EMPRESA.Funcionario
WHERE funcionario.Pnome = 'João';

SELECT *
FROM EMPRESA.Funcionario
WHERE Funcionario.Sexo = 'M' AND Funcionario.Salario >= 30000;

SELECT *
FROM EMPRESA.Funcionario
WHERE Funcionario.endereco LIKE '%São Paulo%'
OR Funcionario.endereco LIKE '%Curitiba%';

SELECT *
FROM EMPRESA.Funcionario
WHERE NOT Funcionario.endereco LIKE '%São Paulo%';

SELECT *
FROM EMPRESA.Funcionario
ORDER BY Funcionario.Salario DESC;

SELECT *
FROM EMPRESA.Funcionario
WHERE   Cpf_supervisor IS NULL;

SELECT *
FROM EMPRESA.Funcionario
WHERE  Cpf_supervisor IS NOT NULL;

SELECT *
FROM EMPRESA.Funcionario
WHERE  Cpf_supervisor IS NOT NULL 
ORDER BY Funcionario.Salario DESC
LIMIT 3;

SELECT MIN(Salario) 
FROM EMPRESA.Funcionario;

SELECT *
FROM EMPRESA.Funcionario
WHERE Funcionario.Salario = (SELECT MIN(Salario) FROM EMPRESA.Funcionario);

SELECT MAX(Salario)
FROM EMPRESA.Funcionario;

SELECT *
FROM EMPRESA.Funcionario
WHERE Funcionario.Salario = (SELECT MAX(Salario) FROM EMPRESA.Funcionario);

SELECT COUNT(Pnome)
FROM EMPRESA.Funcionario;

SELECT AVG(Salario)
FROM EMPRESA.Funcionario;

SELECT SUM(Salario)
FROM EMPRESA.Funcionario;

SELECT *
FROM EMPRESA.Funcionario
WHERE Funcionario.Datanasc LIKE '__72%';

SELECT *
FROM EMPRESA.Funcionario
WHERE Funcionario.Salario IN(SELECT MIN(Salario) FROM EMPRESA.Funcionario)
AND Funcionario.sexo = 'F';


SELECT Pnr, Horas
FROM trabalha_em
WHERE  Fcpf = '33344555587';


SELECT DISTINCT Fcpf
FROM trabalha_em
WHERE (Pnr, Horas) IN(SELECT Pnr, Horas FROM trabalha_em WHERE  Fcpf = '33344555587');

SELECT *
FROM funcionario
WHERE Cpf IN(SELECT DISTINCT Fcpf FROM trabalha_em WHERE (Pnr, Horas) IN(SELECT Pnr, Horas FROM trabalha_em WHERE  Fcpf = '33344555587'));

SELECT *
FROM Funcionario
WHERE Salario BETWEEN 30000 AND 40000
AND Dnr = '5';

SELECT Pnome AS 'Nome', Unome  AS 'Sobrenome'
FROM funcionario;

SELECT F.Pnome, F.Minicial, F.Unome
FROM funcionario AS F, departamento AS D
WHERE F.Dnr = D.Dnumero
AND Dnome = 'Pesquisa';

SELECT F.Pnome, F.Minicial, F.Unome, P.Projnome
FROM funcionario AS F, Projeto AS P;

SELECT F.Pnome AS 'Nome', F.Unome  AS 'Sobrenome', D.Nome_dependente AS 'Nome', D.Parentesco AS 'Parentesco'
FROM funcionario AS F, dependente AS D 
WHERE D.Fcpf = F.Cpf;

SELECT *
FROM Projeto AS P, Departamento AS D
WHERE P.Dnum = D.Dnumero;

SELECT F.Pnome AS 'Nome', P.Projnome AS 'Nome do Projeto'
FROM Funcionario AS F, trabalha_em AS T, projeto AS P
WHERE T.Fcpf = F.Cpf
AND T.Pnr = P.Projnumero
ORDER BY F.Pnome;

SELECT Pnome, Unome, Endereco
FROM Funcionario
INNER JOIN Departamento
ON Funcionario.Dnr = Departamento.Dnumero
WHERE Departamento.Dnome = 'Pesquisa'
ORDER BY Pnome;

SELECT F.Pnome AS 'Nome', P.Projnome AS 'Nome do Projeto'
FROM Funcionario AS F
INNER JOIN trabalha_em AS T
ON F.Cpf = T.Fcpf
INNER JOIN projeto AS P
ON T.Pnr = P.Projnumero
WHERE P.Projnome = 'Produtox'
ORDER BY F.Pnome ASC;

SELECT P.Projnome, D.Dnome, F.Unome, F.Endereco, F.Datanasc
FROM Funcionario AS F
INNER JOIN Departamento AS D
ON F.Cpf = D.Cpf_Gerente
INNER JOIN Projeto AS P
ON D.Dnumero = P.Dnum 
WHERE P.Projlocal = 'Mauá';

SELECT S.Pnome AS 'Supervisionados', G.Pnome AS 'Gerentes'
FROM Funcionario AS S
LEFT JOIN Funcionario AS G
ON S.Cpf_supervisor = G.Cpf
ORDER BY S.Pnome ASC;



