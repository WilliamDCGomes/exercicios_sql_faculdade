CREATE DATABASE TrabalhoFIB;


-- 2
CREATE TABLE CurrentAccount(
	AccountNumber int(5) PRIMARY KEY,
	Client varchar(50) NOT NULL,
    Cash decimal(8,2) NOT NULL
);

CREATE TABLE Move(
	AccountNumber int(5) NOT NULL,
    MoveDate date NOT NULL,
    Value decimal(8,2) NOT NULL,
    Operation ENUM ('S', 'D')
);

CREATE TABLE Operation(
    OperationDate date NOT NULL,
    Operation ENUM ('S', 'D'),
	Value decimal(8,2) NOT NULL
);

CREATE TABLE Auditor(
	OperationDate date NOT NULL,
    Employee varchar(50),
    Operation ENUM ('S', 'D'),
	Value decimal(8,2) NOT NULL
);

-- 3

INSERT INTO `CurrentAccount`(`AccountNumber`, `Client`, `Cash`) 
VALUES (1,'João',5000.00);

INSERT INTO `CurrentAccount`(`AccountNumber`, `Client`, `Cash`) 
VALUES (2,'Denize',3000.00);

INSERT INTO `CurrentAccount`(`AccountNumber`, `Client`, `Cash`) 
VALUES (3,'Kamila',3200.00);

INSERT INTO `CurrentAccount`(`AccountNumber`, `Client`, `Cash`) 
VALUES (4,'Jennifer',5000.00);

-- 4
DELIMITER $$

CREATE TRIGGER trg_controle_mov_cc AFTER INSERT ON Move FOR EACH ROW 
BEGIN
	SET @func = '';
	SET @OperationDate = NEW.MoveDate;
    SET @Value = NEW.Value;
    SET @Operation = NEW.Operation;
    SET @AccountNumber = NEW.AccountNumber;
    
    
    
    IF (@Operation = 'S') THEN
    	UPDATE CurrentAccount SET Cash = Cash - @Value WHERE AccountNumber = @AccountNumber;
        SET @func = 'João';
    ELSE
    	UPDATE CurrentAccount SET Cash = Cash + @Value WHERE AccountNumber = @AccountNumber;
        SET @func = 'Denize';
    END IF;
      
    INSERT INTO Auditor(OperationDate, Employee, Operation, Value) VALUES(@OperationDate, @func, @Operation, @Value);
    INSERT INTO Operation(OperationDate, Operation, Value) VALUES(@OperationDate, @Operation, @Value);
    
END$$

DELIMITER ;


INSERT INTO `Move`(`AccountNumber`, `MoveDate`, `Value`, `Operation`) 
VALUES (1,sysdate(),200,'S');

INSERT INTO `Move`(`AccountNumber`, `MoveDate`, `Value`, `Operation`) 
VALUES (2,sysdate(),200,'D');

DELIMITER $$

CREATE TRIGGER trg_controle_mov_estorno AFTER DELETE ON Move FOR EACH ROW
BEGIN
	SET @func = '';
	SET @OperationDate = OLD.MoveDate;
    SET @Value = OLD.Value;
    SET @Operation = OLD.Operation;
    SET @AccountNumber = OLD.AccountNumber;
        
    IF (@Operation = 'S') THEN
    	UPDATE CurrentAccount SET Cash = Cash + @Value WHERE AccountNumber = @AccountNumber;
        SET @func = 'João';
    ELSE
    	UPDATE CurrentAccount SET Cash = Cash - @Value WHERE AccountNumber = @AccountNumber;
        SET @func = 'Denize';
    END IF;
      
    INSERT INTO Auditor(OperationDate, Employee, Operation, Value) VALUES(@OperationDate, @func, @Operation, @Value);
    INSERT INTO Operation(OperationDate, Operation, Value) VALUES(@OperationDate, @Operation, @Value);
    
    
END$$

DELIMITER $$

CREATE TRIGGER tr_impedirdel_Client BEFORE DELETE ON CurrentAccount FOR EACH ROW
BEGIN

        SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Não é possível deletar o cliente';
    
END$$

DELIMITER ;