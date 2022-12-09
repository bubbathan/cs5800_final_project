USE HOSPITAL;

DROP PROCEDURE IF EXISTS register_patient;
DROP PROCEDURE IF EXISTS patient_report;
DROP PROCEDURE IF EXISTS schedule_staff;
DROP PROCEDURE IF EXISTS get_all_available_rooms;
DROP PROCEDURE IF EXISTS get_medications;
DROP PROCEDURE IF EXISTS get_on_call_doctors;
DROP PROCEDURE IF EXISTS set_medication_cost;
DROP PROCEDURE IF EXISTS update_patient;
DROP PROCEDURE IF EXISTS set_procedure_cost;

DELIMITER $$
CREATE PROCEDURE register_patient (IN patientId INT,
                                    IN pName VARCHAR (100), 
                                    IN ssn VARCHAR (11), 
                                    IN address VARCHAR (100), 
                                    IN phone VARCHAR (50), 
                                    IN insuranceId INT, 
                                    IN pcp VARCHAR (100)
                                    )
begin
	insert into PATIENT (patientId, name, ssn, address, phone, insuranceId, pcp) 
	values (patientId, pName, ssn, address, phone, insuranceId, pcp);
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE patient_report (IN pId INT,
                                OUT pName VARCHAR (100),
                                OUT phone VARCHAR (50),
                                OUT bill DECIMAL (20, 2),
                                OUT procedures VARCHAR (1000),
                                OUT prescriptions VARCHAR (1000)
                                )
begin
	select name, phone into pName, phone from PATIENT where patientId = pId;
	select sum(cost) into bill from MPROCEDURE where code in (select code from TREAT where patientId = pId);
	select group_concat(name) into procedures from MPROCEDURE where code in (select procedureCode from TREAT where patientId = pId); 
	select group_concat(name) into prescriptions from MEDICATION where code in (select code from PRESCRIBES where patientId = pId);

	select pName, phone, bill, procedures, prescriptions;

end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE schedule_staff (IN eName VARCHAR (100),
                                IN code INT,
                                IN shiftDate DATE
                                )
begin
	select employeeId into @eId from STAFF where employeeName = eName;

	insert into ISSCHEDULED (employeeId, code, scheduledDate) values (@eId, code, shiftDate);
end$$
DELIMITER ;


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