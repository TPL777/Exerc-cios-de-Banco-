DELIMITER 
CREATE TRIGGER insere_cliente
AFTER INSeRT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Novo cliente inserido em ', NOW()));
END;

DELIMITER ;

