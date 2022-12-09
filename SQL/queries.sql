USE HOSPITAL;





DROP PROCEDURE IF EXISTS get_all_available_rooms;
DROP PROCEDURE IF EXISTS get_medications;
DROP PROCEDURE IF EXISTS get_on_call_doctors;
DROP PROCEDURE IF EXISTS set_medication_cost;
DROP PROCEDURE IF EXISTS update_patient;
DROP PROCEDURE IF EXISTS set_procedure_cost;













































DELIMITER $$
CREATE PROCEDURE get_all_available_rooms()
begin
    select * from ROOM where availability = 1;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_medications()
begin
    select * from MEDICATION;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_on_call_doctors()
begin
    select employeeName from STAFF where employeeId in (select employeeId from DOCTOR where onCall = 1);
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE set_medication_cost (IN refCode INT, IN newCost DECIMAL (20, 2))
begin
    UPDATE MEDICATION
    SET cost = newCost 
    WHERE code = refCode;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE set_procedure_cost (IN refCode INT, IN newCost DECIMAL (20, 2))
begin
	UPDATE MPROCEDURE
    SET cost = newCost
    WHERE code = refCode;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_patient (IN n_patientId INT,
                                    IN n_name VARCHAR (100), 
                                    IN n_ssn VARCHAR (11), 
                                    IN n_address VARCHAR (100), 
                                    IN n_phone VARCHAR (50), 
                                    IN n_insuranceId INT, 
                                    IN n_pcp VARCHAR (100))
begin
	UPDATE PATIENT 
    SET name = n_name, ssn = n_ssn, address = n_address, phone = n_phone, insuranceId = n_insuranceId, pcp = n_pcp
	WHERE patientId = n_patientId;
end$$
DELIMITER ;