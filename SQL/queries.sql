DELIMITER $$
CREATE PROCEDURE register_patient (IN name VARCHAR (100), 
                                    IN ssn VARCHAR (11), 
                                    IN address VARCHAR (100), 
                                    IN phone VARCHAR (50), 
                                    IN insuranceId INT, 
                                    IN pcp VARCHAR (100)
                                    OUT patientId INT)
begin
    insert into PATIENT (name, ssn, address, phone, insuranceId, pcp) 
    values (name, ssn, address, phone, insuranceId, pcp);
    set patientId = last_insert_id();
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE patient_report (IN patientId INT,
                                OUT name VARCHAR (100),
                                OUT phone VARCHAR (50),
                                OUT bill DECIMAL (20, 2),
                                OUT procedures VARCHAR (1000),
                                OUT prescriptions VARCHAR (1000))
begin
    select name, phone into name, phone from PATIENT where patientId = patientId;
    select sum(cost) into bill from BILL where patientId = patientId;
    select group_concat(name) into procedures from MPROCEDURE where code in (select procedureCode from TREAT where patientId = patientId); 
    select group_concat(name) into prescriptions from MEDICATION where code in (select medicationCode from PRESCRIBE where patientId = patientId);
end$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE schedule_staff(IN employeeName VARCHAR (100),
                                IN code INT,
                                IN shiftDate DATE,
                                OUT employeeName VARCHAR (100),
                                OUT shiftDate Date)
begin
    declare tempId INT;
    select employeeId into tempId from STAFF where employeeName = employeeName;

    insert into ISSCHEDULED (employeeId, code, shiftDate) values (tempId, code, shiftDate);
    set employeeName = employeeName;
    set shiftDate = shiftDate;
end$$
DELIMITER ;




