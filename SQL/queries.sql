DELIMITER $$
CREATE PROCEDURE get_all_available_rooms()
begin
    select * from ROOM where availability = 1;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_medications()
begin
    select name from MEDICATION;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE get_on_call_doctors()
begin
    select employeeName from DOCTOR where onCall = 1;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_medication_cost (IN refCode INT,
                                        IN newCost DECIMAL (100,2))
begin
    update MEDICATION
    set cost = newCost
    where code = refCode;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_procedure_cost (IN refCode INT,
                                        IN newCost DECIMAL (100,2))
begin
	update MPROCEDURE
    set cost = newCost
    where code = refCode;
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_patient (IN n_patientId INT,
                                    IN n_name VARCHAR (100), 
                                    IN n_ssn VARCHAR (11), 
                                    IN n_address VARCHAR (100), 
                                    IN n_phone VARCHAR (50), 
                                    IN n_insuranceId INT, 
                                    IN n_pcp VARCHAR (100)
                                    )
begin
	update PATIENT 
    set name = n_name, ssn = n_ssn, address = n_address, phone = n_phone, insuranceId = n_insuranceId, pcp = n_pcp
	where patientId = n_patientId;
end$$
DELIMITER ;