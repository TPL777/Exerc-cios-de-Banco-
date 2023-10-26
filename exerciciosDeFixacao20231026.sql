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

DELIMITER //
CREATE TrIGGER impede_atualizacao_nome_vazio
BEFoRE UPDATE ON Clientes
FOREACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        INSERT INTO Auditoria (mensagem)
        VALUES (CONCAT('Tentativa de atualização do nome para vazio ou NULL em ', NOW()));
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome não pode ser vazio ou NULL!';
    END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER decrementa_estoque_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;

    IF NEW.quantidade > 5 THEEN
        INSERT INTO Auditoria (mensagem)
        VALUES (CONCAT('Estoque baixo para o produto ', NEW.produto_id, ' em ', NOW()));
    END IF;
END;
//
DELIMITER ;
