DROP DATABASE IF EXISTS HOSPITAL;
CREATE DATABASE IF NOT EXISTS HOSPITAL;

USE HOSPITAL;

DROP TABLE IF EXISTS
      STAFF
    , PATIENT
    , SHIFT
    , PROCEDURE
    , DEPARTMENT
    , LOCATION
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
    , WORKSIN
    , WORKSWITH
    , PRESCRIBES
    , HOUSES
    , ISSCHEDULED
    , LOCATEDIN
    , DIAGNOSED
    , TREAT
    , VISIT
    , STAYS

CREATE TABLE STAFF (
    employeeId    INT             NOT NULL
  , ssn           VARCHAR(11)     NOT NULL    UNIQUE
  , employeeName  VARCHAR(100)    NOT NULL
  , supervisor    INT
  , wage          DECIMAL(20, 2)
  , address       VARCHAR(100)
  , phone         VARCHAR(50)
  , shiftCode     INT
  , PRIMARY KEY (employeeId)
  , FOREIGN KEY (supervisor) REFERENCES STAFF (employeeId)
  , FOREIGN KEY (shiftCode) REFERENCES SHIFT (code)
);

CREATE TABLE DOCTOR (
    employeeId    INT             NOT NULL    REFERENCES STAFF (employeeId)
  , position      VARCHAR(100)
  , onCall        BIT             NOT NULL
  , PRIMARY KEY (employeeId)
);

CREATE TABLE SURGEON (
    employeeId    INT             NOT NULL    REFERENCES DOCTOR (employeeId)
  , surgeonType   VARCHAR(100)
  , PRIMARY KEY (employeeId)
);

CREATE TABLE GENERAL (
    employeeId    INT             NOT NULL    REFERENCES DOCTOR (employeeId)
  , type          VARCHAR(100)
  , PRIMARY KEY (employeeId)
);

CREATE TABLE SPECIALIST (
    employeeId    INT             NOT NULL    REFERENCES DOCTOR (employeeId)
  , specialtyType   VARCHAR(100)
  , PRIMARY KEY (employeeId)
);

CREATE TABLE NURSE (
    employeeId    INT             NOT NULL    REFERENCES STAFF (employeeId)
  , position      VARCHAR(100)
  , isRegistered  BIT             NOT NULL
  , credentials   VARCHAR(100)    NOT NULL
  , onCall        BIT             NOT NULL
  , PRIMARY KEY (employeeId)
  , CHECK(credentials IN ('CNA', 'LPN', 'RN', 'APRN', 'NCS', 'None'))
);

CREATE TABLE PATIENT (
    patientId     INT           NOT NULL
  , ssn           VARCHAR(11)   NOT NULL    UNIQUE
  , name          VARCHAR(100)  NOT NULL
  , address       VARCHAR(100)
  , phone         VARCHAR(50)
  , insuranceId   INT
  , pcp           VARCHAR(100)
  , PRIMARY KEY (patientId)
);

CREATE TABLE SHIFT (
    code        INT           NOT NULL
  , startTime   TIME
  , endTime     TIME
  , days        VARCHAR(100)
  , PRIMARY KEY (code)
);

CREATE TABLE PROCEDURE (
    code  INT               NOT NULL
  , name  VARCHAR(250)      NOT NULL
  , cost  DECIMAL(100, 2)
  , PRIMARY KEY (code)
);

CREATE TABLE OUTPATIENTPROCEDURE (
    code  INT   NOT NULL  REFERENCES PROCEDURE (code)
  , PRIMARY KEY (code)
);

CREATE TABLE INPATIENTPROCEDURE (
    code         INT              NOT NULL   REFERENCES PROCEDURE (code)
  , avgStayLen   DECIMAL(100, 2)
  , PRIMARY KEY (code)
);

CREATE TABLE DEPARTMENT (
    departmentId  INT           NOT NULL
  , name          VARCHAR(150)
  , head          INT
  , PRIMARY KEY (departmentId)
  , FOREIGN KEY (head) references STAFF (employeeId)
);

CREATE TABLE LOCATION (
    locationId  INT           NOT NULL
  , address     VARCHAR(100)  NOT NULL
  , name        VARCHAR(150)
  , PRIMARY KEY (locationId)
);

CREATE TABLE ROOM (
    roomNumber    VARCHAR(20)   NOT NULL
  , roomType      VARCHAR(100)
  , floor         INT           NOT NULL
  , availability  BIT           NOT NULL
  , PRIMARY KEY (roomNumber)
);

CREATE TABLE MEDICATION (
    code    INT               NOT NULL
  , name    VARCHAR(150)      NOT NULL
  , brand   VARCHAR(150)      NOT NULL
  , cost    DECIMAL(100, 2)
  , PRIMARY KEY (code)
);

CREATE TABLE DIAGNOSIS (
    diagnosisName   VARCHAR(250)    NOT NULL
  , symptoms        VARCHAR(1000)
  , PRIMARY KEY (diagnosisName)
);

CREATE TABLE WORKSIN (
    employeeId    INT   NOT NULL
  , departmentId  INT   NOT NULL
  , PRIMARY KEY (employeeId, departmentId)
  , FOREIGN KEY (employeeId) REFERENCES STAFF (employeeId)
  , FOREIGN KEY (departmentId) REFERENCES DEPARTMENT (departmentId)
);

CREATE TABLE WORKSWITH (
    doctorId  INT   NOT NULL
  , nurseId   INT   NOT NULL
  , PRIMARY KEY (doctorId, nurseId)
  , FOREIGN KEY (doctorId) REFERENCES DOCTOR (employeeId)
  , FOREIGN KEY (nurseId) REFERENCES NURSE (employeeId)
);

CREATE TABLE PRESCRIBES (
    employeeId      INT         NOT NULL
  , patientId       INT         NOT NULL
  , code            INT         NOT NULL
  , datePrescribed  DATE        NOT NULL
  , dosage          DECIMAL     NOT NULL
  , measurementType VARCHAR(20) NOT NULL
  , PRIMARY KEY (employeeId, patientId, code, datePrescribed)
  , FOREIGN KEY (employeeId) REFERENCES DOCTOR (employeeId)
  , FOREIGN KEY (patientId) REFERENCES PATIENT (patientId)
  , FOREIGN KEY (code) REFERENCES MEDICATION (code)
);

CREATE TABLE HOUSES (
    locationId  INT           NOT NULL
  , roomNumber  VARCHAR(20)   NOT NULL
  , PRIMARY KEY (locationId, roomNumber)
  , FOREIGN KEY (locationId) REFERENCES LOCATION (locationId)
  , FOREIGN KEY (roomNumber) REFERENCES ROOM (roomNumber)
);

CREATE TABLE ISSCHEDULED (
    employeeId  INT   NOT NULL
  , code        INT   NOT NULL
  , PRIMARY KEY (employeeId, code)
  , FOREIGN KEY (employeeId) REFERENCES STAFF (employeeId)
  , FOREIGN KEY (code) REFERENCES SHIFT (code)
);

CREATE TABLE LOCATEDIN (
    departmentId  INT   NOT NULL
  , locationId    INT   NOT NULL
  , PRIMARY KEY (departmentId, locationId)
  , FOREIGN KEY (departmentId) REFERENCES DEPARTMENT (departmentId)
  , FOREIGN KEY (locationId) REFERENCES LOCATION (locationId)
);

CREATE TABLE DIAGNOSED (
    patientId       INT           NOT NULL
  , diagnosisName   VARCHAR(250)  NOT NULL
  , PRIMARY KEY (patientId, diagnosisName)
  , FOREIGN KEY (patientId) REFERENCES PATIENT (patientId)
  , FOREIGN KEY (diagnosisName) REFERENCES DIAGNOSIS (diagnosisName)
);

CREATE TABLE TREAT (
    procedureCode   INT   NOT NULL
  , medicationCode  INT   NOT NULL
  , patientId       INT   NOT NULL
  , employeeId      INT   NOT NULL
  , PRIMARY KEY (procedureCode, medicationCode, patientId, employeeId)
  , FOREIGN KEY (procedureCode) REFERENCES PROCEDURE (code)
  , FOREIGN KEY (medicationCode) REFERENCES MEDICATION (code)
  , FOREIGN KEY (patientId) REFERENCES PATIENT (patientId)
  , FOREIGN KEY (employeeId) REFERENCES DOCTOR (employeeId)
);

CREATE TABLE VISIT (
    employeeId  INT           NOT NULL
  , patientId   INT           NOT NULL
  , visitDate   DATE          NOT NULL
  , visitTime   TIME          NOT NULL
  , notes       VARCHAR(500)
  , PRIMARY KEY (employeeId, patientId, visitDate, visitTime)
  , FOREIGN KEY (employeeId) REFERENCES NURSE (employeeId)
  , FOREIGN KEY (patientId) REFERENCES PATIENT (patientId)
);

CREATE TABLE STAYS (
    patientId       INT           NOT NULL
  , roomNumber      VARCHAR(20)   NOT NULL
  , enterDate       DATE          NOT NULL
  , enterTime       TIME
  , dischargeDate   DATE
  , dischargeTime   TIME
  , PRIMARY KEY (patientId, roomNumber, enterDate)
  , FOREIGN KEY (patientId) REFERENCES PATIENT (patientId)
  , FOREIGN KEY (roomNumber) REFERENCES ROOM (roomNumber)
  , CHECK (dischargeDate >= enterDate)
);
