CREATE DATABASE GerenciamentoEmprestimos;
USE GerenciamentoEmprestimos;

CREATE TABLE Itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL	
);

CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    matricula VARCHAR(20) NOT NULL UNIQUE,
    contato VARCHAR(50)
);

CREATE TABLE Emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_item INT,
    id_usuario INT,
    data_emprestimo DATETIME,
    data_vencimento DATETIME,
    estado ENUM('devolvido', 'emprestado') NOT NULL DEFAULT 'devolvido',
    FOREIGN KEY (id_item) REFERENCES Itens(id),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

CREATE TABLE Historico (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_emprestimo INT,
    status_ ENUM('empréstimo', 'devolução') NOT NULL,
    data_acao DATETIME NOT NULL,
    FOREIGN KEY (id_emprestimo) REFERENCES Emprestimos(id)
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
CREATE TRIGGER TriggerAdicionaData
BEFORE INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    SET NEW.data_emprestimo = NOW();

    SET NEW.data_vencimento = NOW() + INTERVAL 1 MINUTE;
END;//

CREATE TRIGGER TriggerAdicionaHistoricoEmprestimo
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
    INSERT INTO Historico (id_emprestimo, status_, data_acao)
    VALUES (
        NEW.id,          
        'empréstimo',    
        NOW()            
    );
    
END; //

DELIMITER //

CREATE TRIGGER TriggerAdicionaHistoricoDevolucao
AFTER UPDATE ON Emprestimos
FOR EACH ROW
BEGIN
    IF OLD.estado = 'emprestado' AND NEW.estado = 'devolvido' THEN
        INSERT INTO Historico (id_emprestimo, status_, data_acao)
        VALUES (
            NEW.id,          
            'devolucao',   
            NOW()           
        );
    END IF;
END //

DELIMITER ;

CREATE VIEW vw_historico_emprestimos AS
SELECT 
    h.id_historico AS 'Histórico',
    e.id AS 'Emprestimos',
    u.nome AS 'Responsável',
    i.nome AS 'Item',
    h.status_ AS 'Status',
    h.data_acao AS 'Atualização',
    u.matricula AS 'Matricula'  
FROM 
    Historico h
JOIN 
    Emprestimos e ON h.id_emprestimo = e.id
JOIN 
    Usuarios u ON e.id_usuario = u.id
JOIN 
    Itens i ON e.id_item = i.id;

    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE RelatorioItensMaisEmprestados()
BEGIN
    SELECT 
        i.nome AS Item,
        COUNT(e.id) AS QuantidadeEmprestimos
    FROM 
        Emprestimos e
    JOIN 
        Itens i ON e.id_item = i.id
    GROUP BY 
        i.id
    ORDER BY 
        QuantidadeEmprestimos DESC;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE RelatorioItensAtrasados()
BEGIN
    SELECT 
        u.nome AS Responsavel,
        i.nome AS Item,
        e.data_emprestimo AS Emprestimo,
        e.data_vencimento AS Vencimento,
        TIMESTAMPDIFF(MINUTE, e.data_vencimento, NOW()) AS DiasAtraso 
    FROM 
        Emprestimos e
    JOIN 
        Itens i ON e.id_item = i.id
    JOIN 
        Usuarios u ON e.id_usuario = u.id
    WHERE 
        e.data_vencimento < NOW() 
        AND e.estado = 'emprestado'
    ORDER BY 
        DiasAtraso DESC;
END;

DELIMITER;

