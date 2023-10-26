DELIMITER //
CREATE TRIGGER insere_cliente
AFTER INSeRT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Novo cliente inserido em ', NOW()));
END;//

DELIMITER ;

DELIMITER //
CREATE TRIGGER tentativa_exclusao_cliente
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES (CONCAT('Tentativa de exclusão de cliente em ', NOW()));
//
DELIMITER ;

DELIMITER //
CRETE TRIGGER atualiza_nome_cliente
AFTER UPDATe ON Clientes
FOR EACh ROW
BEgIN
    IF NEW.nome != OLD.nome THEN
        INSERT INTO Auditoria (mensagem)
        VALUES (CONCAT('Nome do cliente atualizado de "', OLD.nome, '" para "', NEW.nome, '" em ', NOW()));
    END iF;
END;
//
DELIMITER ;
