USE PersonalTrainer;

-- Setup for the trigger exercises.
CREATE TABLE IF NOT EXISTS TriggerPracticeContact (
    ContactId INT AUTO_INCREMENT PRIMARY KEY,
    EmailAddress VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS TriggerPracticeProduct (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS TriggerPracticePriceAudit (
    AuditId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    OldPrice DECIMAL(10, 2) NOT NULL,
    NewPrice DECIMAL(10, 2) NOT NULL,
    ChangedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO TriggerPracticeProduct (ProductId, ProductName, Price)
VALUES (1, 'Practice product', 10.00);

--------------------

-- Activity 1
-- Normalize an email address before insertion.
DROP TRIGGER IF EXISTS trg_TriggerPracticeContact_NormalizeEmail;
DELIMITER //
CREATE TRIGGER trg_TriggerPracticeContact_NormalizeEmail
BEFORE INSERT ON TriggerPracticeContact
FOR EACH ROW
BEGIN
    SET NEW.EmailAddress = LOWER(TRIM(NEW.EmailAddress));
END //
DELIMITER ;

INSERT INTO TriggerPracticeContact (EmailAddress)
VALUES ('  Student@Example.com  ');

SELECT ContactId, EmailAddress
FROM TriggerPracticeContact
ORDER BY ContactId DESC
LIMIT 1;

--------------------

-- Activity 2
-- Reject a negative product price.
DROP TRIGGER IF EXISTS trg_TriggerPracticeProduct_ValidatePrice;
DELIMITER //
CREATE TRIGGER trg_TriggerPracticeProduct_ValidatePrice
BEFORE INSERT ON TriggerPracticeProduct
FOR EACH ROW
BEGIN
    IF NEW.Price < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END //
DELIMITER ;

INSERT INTO TriggerPracticeProduct (ProductName, Price)
VALUES ('Valid practice product', 12.50);

-- Uncomment this statement to verify that the trigger rejects it.
-- INSERT INTO TriggerPracticeProduct (ProductName, Price)
-- VALUES ('Invalid practice product', -1.00);

--------------------

-- Activity 3
-- Record a price change after a Product update.
DROP TRIGGER IF EXISTS trg_TriggerPracticeProduct_AuditPrice;
DELIMITER //
CREATE TRIGGER trg_TriggerPracticeProduct_AuditPrice
AFTER UPDATE ON TriggerPracticeProduct
FOR EACH ROW
BEGIN
    IF OLD.Price <> NEW.Price THEN
        INSERT INTO TriggerPracticePriceAudit
            (ProductId, OldPrice, NewPrice)
        VALUES
            (OLD.ProductId, OLD.Price, NEW.Price);
    END IF;
END //
DELIMITER ;

UPDATE TriggerPracticeProduct
SET Price = Price + 1.00
WHERE ProductId = 1;

SELECT ProductId, OldPrice, NewPrice, ChangedAt
FROM TriggerPracticePriceAudit
WHERE ProductId = 1
ORDER BY AuditId DESC;

--------------------

-- Activity 4
-- Inspect the exercise triggers.
SHOW TRIGGERS;
SHOW CREATE TRIGGER trg_TriggerPracticeContact_NormalizeEmail;
SHOW CREATE TRIGGER trg_TriggerPracticeProduct_ValidatePrice;
SHOW CREATE TRIGGER trg_TriggerPracticeProduct_AuditPrice;

-- To remove only these exercise triggers, uncomment:
-- DROP TRIGGER IF EXISTS trg_TriggerPracticeContact_NormalizeEmail;
-- DROP TRIGGER IF EXISTS trg_TriggerPracticeProduct_ValidatePrice;
-- DROP TRIGGER IF EXISTS trg_TriggerPracticeProduct_AuditPrice;
