DROP DATABASE IF EXISTS HOSPITAL;
CREATE DATABASE IF NOT EXISTS HOSPITAL;

USE HOSPITAL;

DROP TABLE IF EXISTS
      STAFF
    , PATIENT
    , SHIFT
    , PROCEDURE
    , DEPARTMENT
    , BUILDING
    , ROOM
    , MEDICATION
    , DIAGNOSIS
    , DOCTOR
    , SURGEON
    , GENERAL
    , SPECIALIST
    , NURSE
    , OUTPATIENTPROCEDURE
    , INPATIENTPROCEDURE

CREATE TABLE STAFF(
    employeeId INT
  , ssn           VARCHAR(11)
  , employeeName  VARCHAR(100)
  , supervisor    INT
  , wage          DECIMAL(20, 2)
  , address       VARCHAR(100)
  , phone         VARCHAR(50)
  , shiftCode     INT
  , PRIMARY KEY(employeeId)
);

CREATE TABLE DOCTOR(
    employeeId    INT             REFERENCES STAFF(employeeId)
  , position      VARCHAR(100)
  , onCall        BIT
  , PRIMARY KEY(employeeId)
);

CREATE TABLE SURGEON(
    employeeId    INT             REFERENCES DOCTOR(employeeId)
  , surgeonType   VARCHAR(100)
  , PRIMARY KEY(employeeId)
);

CREATE TABLE GENERAL(
    employeeId    INT             REFERENCES DOCTOR(employeeId)
  , type          VARCHAR(100)
  , PRIMARY KEY(employeeId)
);

CREATE TABLE SPECIALIST(
    employeeId    INT             REFERENCES DOCTOR(employeeId)
  , specialtyType   VARCHAR(100)
  , PRIMARY KEY(employeeId)
);

CREATE TABLE NURSE(
    employeeId    INT             REFERENCES STAFF(employeeId)
  , position      VARCHAR(100)
  , isRegistered  BIT
  , credentials   VARCHAR(100)
  , onCall        BIT
  , PRIMARY KEY(employeeId)
);

CREATE TABLE PATIENT(
    patientId     INT
  , ssn           VARCHAR(11)
  , name          VARCHAR(100)
  , address       VARCHAR(100)
  , phone         VARCHAR(50)
  , insuranceId   INT
  , pcp           VARCHAR(100)
  , PRIMARY KEY(patientId)
);

CREATE TABLE SHIFT(
    code        INT
  , startTime   TIME
  , endTime     TIME
  , days        VARCHAR(100)
  , PRIMARY KEY(code)
);

CREATE TABLE PROCEDURE(
    code  INT
  , name  VARCHAR(250)
  , cost  DECIMAL(100, 2)
  , PRIMARY KEY(code)
);

CREATE TABLE OUTPATIENTPROCEDURE(
    code  INT   REFERENCES PROCEDURE(code)
  , PRIMARY KEY(code)
);

CREATE TABLE INPATIENTPROCEDURE(
    code            INT             REFERENCES PROCEDURE(code)
  , avgStayLength   DECIMAL(10, 2)
  , PRIMARY KEY(code)
);

CREATE TABLE DEPARTMENT(
    departmentId  INT
  , name          VARCHAR(150)
  , head          INT
  , location      VARCHAR(100)
  , PRIMARY KEY(departmentId)
  , FOREIGN KEY (head) references STAFF(employeeId)
);

CREATE TABLE BUILDING(
    buildingId  INT
  , address     VARCHAR(100)
  , name        VARCHAR(150)
  , wing        VARCHAR(150)
  , PRIMARY KEY(buildingId)
);

CREATE TABLE ROOM(
    roomNumber    INT
  , roomType      VARCHAR(100)
  , floor         INT
  , availability  BIT
  , PRIMARY KEY(roomNumber)
);

CREATE TABLE MEDICATION(
    code    INT
  , name    VARCHAR(150)
  , brand   VARCHAR(150)
  , cost    DECIMAL(100, 2)
  , PRIMARY KEY(code)
);

CREATE TABLE DIAGNOSIS(
    diagnosisName   VARCHAR(250)
  , symptoms        VARCHAR(1000)
  , PRIMARY KEY(diagnosisName)
);


