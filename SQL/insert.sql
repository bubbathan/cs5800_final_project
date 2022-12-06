USE HOSPITAL;

INSERT INTO SHIFT VALUES
      (1, '09:00:00', '17:00:00', 'weekdays')
    , (2, '09:00:00', '13:00:00', 'weekdays')
    , (3, '13:00:00', '17:00:00', 'weekdays')
    , (4, '13:00:00', '21:00:00', 'everyday')
    , (5, '21:00:00', '05:00:00', 'everyday')
    , (6, '01:00:00', '09:00:00', 'everyday')
    , (7, '08:00:00', '16:00:00', 'everyday');

INSERT INTO STAFF VALUES
      (1, '000-00-0001', 'JIM', null, 180000.00, '123 Main St', '555-123-4567')
    , (2, '000-00-0002', 'JANE', 1, 160000.00, '123 Main Blvd', '555-234-5678')
    , (3, '000-00-0003', 'JOHN', 1, 160000.00, '123 Main Ave', '555-345-6789')
    , (4, '000-00-0004', 'STACEY', 1, 160000.00, '123 Main Rd', '555-456-7890')
    , (5, '000-00-0005', 'QUINN', 2, 140000.00, '234 Main St', '555-567-8901')
    , (6, '000-00-0006', 'GEOFF', 2, 140000.00, '234 Main Blvd', '555-678-9012')
    , (7, '000-00-0007', 'AMANDA', 3, 140000.00, '234 Main Ave', '555-789-0123')
    , (8, '000-00-0008', 'BRITTANY', 3, 140000.00, '234 Main Rd', '555-890-1234')
    , (9, '000-00-0009', 'GEORGE', 4, 100000.00, '345 Main St', '555-901-2345')
    , (10, '000-00-0010', 'TIFFANY', 4, 100000.00, '345 Main Blvd', '555-012-3456')
    , (11, '000-00-0011', 'BUB', 2, 130000.00, '345 Main Ave', '555-098-7654')
    , (12, '000-00-0012', 'STEVEN', 2, 130000.00, '345 Main Rd', '555-555-5555');

INSERT INTO DOCTOR VALUES
      (2, 'MEDICAL DIRECTOR', 0)
    , (5, 'ATTENDING PHYSICIAN', 1)
    , (6, 'ATTENDING PHYSICIAN', 1)
    , (11, 'ATTENDING PHYSICIAN', 1)
    , (12, 'ATTENDING PHYSICIAN', 0);

INSERT INTO SURGEON VALUES
      (2, 'CARDIOVASCULAR')
    , (5, 'NEUROSURGERY');

INSERT INTO GENERAL VALUES (6, 'FAMILY PRACTITIONER');

INSERT INTO SPECIALIST VALUES
    (11, 'OBSTETRICS AND GYNECOLOGY')
  , (12, 'PEDIATRICS');

INSERT INTO NURSE VALUES
      (3, 'NURSING DIRECTOR', 1, 'RN', 0)
    , (7, 'FULL-TIME', 1, 'RN', 1)
    , (8, 'FULL-TIME', 0, 'CNA', 1);

INSERT INTO PATIENT VALUES
      (0001, '111-111-1110', 'JOHN DOE', '111 Main St', '555-111-1111', 123456, 'QUINN')
    , (0002, '111-111-1111', 'JANE DOE', '111 Main St', '555-111-1111', 123456, 'QUINN')
    , (0003, '111-111-1112', 'JIM DOE', '222 Main St', '555-111-1112', 234567, 'GEOFF');

INSERT INTO MPROCEUDRE VALUES
      (1234, 'CESAREAN SECTION', 7500.00)
    , (1235, 'TONSILLECTOMY', 800.00);

INSERT INTO OUTPATIENTPROCEDURE VALUES (1235);

INSERT INTO INPATIENTPROCEDURE VALUES (1234, 48.00);

INSERT INTO DEPARTMENT VALUES
      (121, 'NEUROLOGY')
    , (122, 'OBSTETRICS AND GYNECOLOGY')
    , (123, 'PEDIATRICS')
    , (124, 'ADMINISTRATION');

INSERT INTO LOCATION VALUES
      (111, '100 Main St', 'ADMIN WING')
    , (112, '100 Main St', 'PEDIATRIC WING')
    , (113, '100 Main St', 'INFANT DELIVERY WING')
    , (114, '110 Main St', 'JIMOTHY HALPERT NEUROLOGY BUILDING')

INSERT INTO ROOM VALUES
      ('A-101', 'ADMIN', 1, 0)
    , ('A-102', 'ADMIN', 1, 0)
    , ('A-103', 'PATIENT ROOM', 1, 1)
    , ('A-104', 'PATIENT ROOM', 1, 0)
    , ('A-201', 'POST-OP', 2, 1)
    , ('A-202', 'POST-OP', 2, 1)
    , ('A-203', 'OPERATING ROOM', 2, 0)
    , ('A-204', 'OPERATING ROOM', 2, 1)
    , ('A-301', 'IN-PATIENT STAY', 3, 1)
    , ('A-302', 'IN-PATIENT STAY', 3, 0)
    , ('A-303', 'IN-PATIENT STAY', 3, 1)
    , ('A-304', 'IN-PATIENT STAY', 3, 1)
    , ('B-101', 'PATIENT ROOM', 1, 1)
    , ('B-102', 'PATIENT ROOM', 1, 1)
    , ('B-103', 'PATIENT ROOM', 1, 1)
    , ('B-104', 'PATIENT ROOM', 1, 1)

INSERT INTO MEDICATION VALUES
    (00001, 'ACETAMINOPHEN', 'TYLENOL', 5.00, 'mg')
  , (00002, 'AMOXICILLIN', 'GENERIC', 15.00, 'mL')
  , (00003, 'FLU VACCCINE 2022', 'GENERIC', 0.00, 'mL')
  , (00004, 'COVID-19 VACCINE', 'PFIZER', 0.00, 'mL')
  , (00005, 'IBUPROFEN', 'GENERIC', 5.00, 'mg')

INSERT INTO DIAGNOSIS VALUES
    ('EAR INFECTION', 'earache, feeling of fullness in the ear, ear drainage')
  , ('MIGRAINE', 'severe headache, throbbing or pulsing sensation on the side of the head')

INSERT INTO WORKSIN VALUES
    (1, 124)
  , (2, 124)
  , (5, 122)
  , (6, 123)
  , (11, 121)
  , (12, 123)
  , (3, 124)
  , (7, 122)
  , (8, 123)
  , (4, 124)
  , (9, 124)
  , (10, 124)

INSERT INTO WORKSWITH VALUES
    (5, 7)
  , (6, 8)
  , (12, 8)

INSERT INTO PRESCRIBES VALUES
    (6, 0002, 00002, '2022-05-01', 6.00)
  , (11, 0001, 00001, '2022-05-06', 500.00)

INSERT INTO HOUSES VALUES
    (111, 'A-101')
  , (111, 'A-102')
  , (112, 'A-103')
  , (112, 'A-104')
  , (113, 'A-201')
  , (113, 'A-202')
  , (113, 'A-203')
  , (113, 'A-204')
  , (114, 'A-301')
  , (114, 'A-302')
  , (114, 'A-303')
  , (114, 'A-304')
  , (115, 'B-101')
  , (115, 'B-102')
  , (115, 'B-103')
  , (115, 'B-104')

INSERT INTO ISSCHEDULED VALUES
    (1, 1, '2022-05-02')
  , (2, 1, '2022-05-02')
  , (3, 1, '2022-05-02')
  , (4, 1, '2022-05-02')
  , (5, 7, '2022-05-02')
  , (6, 7, '2022-05-02')
  , (7, 7, '2022-05-02')
  , (8, 7, '2022-05-02')
  , (9, 2, '2022-05-02')
  , (10, 3, '2022-05-02')
  , (11, 7, '2022-05-02')
  , (12, 7, '2022-05-02')
  , (1, 1, '2022-05-03')
  , (2, 1, '2022-05-03')
  , (3, 1, '2022-05-03')
  , (4, 1, '2022-05-03')
  , (5, 7, '2022-05-03')
  , (6, 7, '2022-05-03')
  , (7, 5, '2022-05-03')
  , (8, 5, '2022-05-03')
  , (9, 2, '2022-05-03')
  , (10, 3, '2022-05-03')
  , (11, 7, '2022-05-03')
  , (12, 7, '2022-05-03')
  , (2, 1, '2022-05-05')
  , (3, 1, '2022-05-05')
  , (5, 7, '2022-05-05')
  , (6, 7, '2022-05-05')
  , (7, 7, '2022-05-05')
  , (8, 7, '2022-05-05')
  , (9, 2, '2022-05-05')
  , (10, 3, '2022-05-05')
  , (11, 7, '2022-05-05');

INSERT INTO LOCATEDIN VALUES
    (121, 114)
  , (122, 113)
  , (123, 112)
  , (124, 111);

INSERT INTO DIAGNOSED VALUES
    (0001, 'MIGRAINE')
  , (0002, 'EAR INFECTION');

INSERT INTO TREAT VALUES
    (1234, 00002, 0002, 11)
  , (1235, 00001, 0001, 12);

INSERT INTO VISIT VALUES
    (7, 0002, '2022-05-03', '09:00:00', 'Patient is doing well, no new pain.');

INSERT INTO STAYS VALUES
    (0002, 'A-301', '2022-05-02', '21:00:00', '2022-05-04', '17:00:00');
  
INSERT INTO LEADS VALUES
    (1, 124)
  , (5, 121)
  , (11, 122)
  , (6, 123);
