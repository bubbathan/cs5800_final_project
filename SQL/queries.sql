USE HOSPITAL;

DROP PROCEDURE IF EXISTS register_patient;
DROP PROCEDURE IF EXISTS patient_report;
DROP PROCEDURE IF EXISTS schedule_staff;

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
