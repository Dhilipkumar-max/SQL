-- 3. TCL commands for Banking Systems.
-- COMMIT, ROLLBACK, SAVEPOINT

CREATE TABLE accounts (acc_id INT PRIMARY KEY, balance DECIMAL(10,2));
INSERT INTO accounts VALUES (101, 10000.00), (102, 5000.00);

-- Scenario: Transfer 2000 from 101 to 102
START TRANSACTION;

UPDATE accounts SET balance = balance - 2000 WHERE acc_id = 101;
SAVEPOINT transfer_initiated;

UPDATE accounts SET balance = balance + 2000 WHERE acc_id = 102;

-- If successful:
COMMIT;

-- If error occurred:
-- ROLLBACK TO transfer_initiated;
-- ROLLBACK;
