USE PersonalTrainer;

-- Activity 1
-- Return Workouts for the supplied LevelId.
DROP PROCEDURE IF EXISTS GetWorkoutsByLevel;
DELIMITER //
CREATE PROCEDURE GetWorkoutsByLevel(
    IN p_LevelId INT
)
BEGIN
    SELECT
        w.WorkoutId,
        w.`Name` WorkoutName,
        w.MaxMinutes
    FROM Workout w
    WHERE w.LevelId = p_LevelId
    ORDER BY w.`Name`;
END //
DELIMITER ;

CALL GetWorkoutsByLevel(1);

--------------------

-- Activity 2
-- Return the Invoice total through an OUT parameter.
DROP PROCEDURE IF EXISTS GetInvoiceTotal;
DELIMITER //
CREATE PROCEDURE GetInvoiceTotal(
    IN p_InvoiceId INT,
    OUT p_InvoiceTotal DECIMAL(30, 8)
)
BEGIN
    DECLARE v_InvoiceExists INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_InvoiceExists
    FROM Invoice i
    WHERE i.InvoiceId = p_InvoiceId;

    IF v_InvoiceExists = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'InvoiceId does not exist';
    END IF;

    SELECT COALESCE(SUM(li.Price * li.Quantity), 0)
    INTO p_InvoiceTotal
    FROM InvoiceLineItem li
    WHERE li.InvoiceId = p_InvoiceId;
END //
DELIMITER ;

SET @invoice_id = (SELECT MIN(InvoiceId) FROM Invoice);
SET @invoice_total = 0;
CALL GetInvoiceTotal(@invoice_id, @invoice_total);
SELECT @invoice_id InvoiceId, @invoice_total InvoiceTotal;

--------------------

-- Activity 3
-- Return an Invoice count and paid total for a Client.
DROP PROCEDURE IF EXISTS GetClientInvoiceSummary;
DELIMITER //
CREATE PROCEDURE GetClientInvoiceSummary(
    IN p_ClientId CHAR(36),
    OUT p_InvoiceCount INT,
    OUT p_PaidTotal DECIMAL(30, 8)
)
BEGIN
    SELECT COUNT(*)
    INTO p_InvoiceCount
    FROM Invoice i
    WHERE i.ClientId = p_ClientId;

    SELECT COALESCE(SUM(li.Price * li.Quantity), 0)
    INTO p_PaidTotal
    FROM Invoice i
    INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
    WHERE i.ClientId = p_ClientId
      AND i.InvoiceStatus = 2;
END //
DELIMITER ;

SET @client_id = (SELECT ClientId FROM Invoice ORDER BY InvoiceId LIMIT 1);
SET @invoice_count = 0;
SET @paid_total = 0;
CALL GetClientInvoiceSummary(@client_id, @invoice_count, @paid_total);
SELECT
    @client_id ClientId,
    @invoice_count InvoiceCount,
    @paid_total PaidTotal;

--------------------

-- Activity 4
-- Add the number of Workouts in a Level to an INOUT running count.
DROP PROCEDURE IF EXISTS AddLevelWorkoutCount;
DELIMITER //
CREATE PROCEDURE AddLevelWorkoutCount(
    IN p_LevelId INT,
    INOUT p_RunningCount INT
)
BEGIN
    DECLARE v_LevelWorkoutCount INT DEFAULT 0;

    SELECT COUNT(*)
    INTO v_LevelWorkoutCount
    FROM Workout w
    WHERE w.LevelId = p_LevelId;

    SET p_RunningCount = p_RunningCount + v_LevelWorkoutCount;
END //
DELIMITER ;

SET @running_count = 10;
CALL AddLevelWorkoutCount(1, @running_count);
SELECT @running_count UpdatedRunningCount;

--------------------

-- Activity 5
-- Inspect the exercise procedures.
SHOW CREATE PROCEDURE GetWorkoutsByLevel;
SHOW CREATE PROCEDURE GetInvoiceTotal;
SHOW CREATE PROCEDURE GetClientInvoiceSummary;
SHOW CREATE PROCEDURE AddLevelWorkoutCount;

-- To remove only these exercise procedures, uncomment:
-- DROP PROCEDURE IF EXISTS GetWorkoutsByLevel;
-- DROP PROCEDURE IF EXISTS GetInvoiceTotal;
-- DROP PROCEDURE IF EXISTS GetClientInvoiceSummary;
-- DROP PROCEDURE IF EXISTS AddLevelWorkoutCount;
