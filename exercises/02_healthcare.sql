-- 2. Create patient, doctor, and appointment tables.
-- Use triggers (INSERT, UPDATE, DELETE).
-- Subqueries and joins.

CREATE TABLE doctor (d_id INT PRIMARY KEY, d_name VARCHAR(50), spec VARCHAR(50));
CREATE TABLE patient (p_id INT PRIMARY KEY, p_name VARCHAR(50), age INT);
CREATE TABLE appointment (
    app_id INT PRIMARY KEY, 
    p_id INT, d_id INT, 
    app_date DATE,
    FOREIGN KEY (p_id) REFERENCES patient(p_id),
    FOREIGN KEY (d_id) REFERENCES doctor(d_id)
);

-- Audit Table
CREATE TABLE appointment_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY, 
    app_id INT, 
    action_type VARCHAR(10), 
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Triggers
DELIMITER //
CREATE TRIGGER after_app_insert AFTER INSERT ON appointment FOR EACH ROW
BEGIN INSERT INTO appointment_audit(app_id, action_type) VALUES (NEW.app_id, 'INSERT'); END //

CREATE TRIGGER after_app_update AFTER UPDATE ON appointment FOR EACH ROW
BEGIN INSERT INTO appointment_audit(app_id, action_type) VALUES (NEW.app_id, 'UPDATE'); END //

CREATE TRIGGER after_app_delete AFTER DELETE ON appointment FOR EACH ROW
BEGIN INSERT INTO appointment_audit(app_id, action_type) VALUES (OLD.app_id, 'DELETE'); END //
DELIMITER ;

-- Subquery Example: Patients with more than 1 appointment
SELECT p_name FROM patient 
WHERE p_id IN (SELECT p_id FROM appointment GROUP BY p_id HAVING COUNT(*) > 1);

-- Join Example
SELECT p.p_name, d.d_name, a.app_date 
FROM appointment a
JOIN patient p ON a.p_id = p.p_id
JOIN doctor d ON a.d_id = d.d_id;
