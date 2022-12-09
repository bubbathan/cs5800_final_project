'''
Registers a new patient into the DB
Input:
    db: database object
    cursor: cursor object

author : skal-chin
'''
def register_patient(db, cursor):

    print('Input patient ID (REQUIRED)')
    id = input()

    print('Input patient name (REQUIRED)')
    name = input()

    print('Input patient ssn (REQUIRED)')
    ssn = input()

    print('Input patient address (OPTIONAL)')
    address = input()
    if not address:
        address = None

    print('Input patient phone (OPTIONAL)')
    phone = input()
    if not phone:
        phone = None

    print('Input patient insurance id (OPTIONAL)')
    insuranceId = input()
    if not insuranceId:
        insuranceId = None

    print('Input patient pcp (OPTIONAL)')
    pcp = input()
    if not pcp:
        pcp = None

    results = cursor.callproc('register_patient', [id, name, ssn, address, phone, insuranceId, pcp])
    db.commit()

    print('New patient has been registered')
    print(results)

    return

'''
Generates a patient report which includes:
    - Patient name
    - Patient phone
    - Patient bill
    - Patient procedures
    - Patient prescriptions
Input:
    db: database object
    cursor: cursor object

author : skal-chin
'''
def patient_report(db, cursor):

    cursor.execute('SELECT patientId FROM patient')
    patientIds = [patient[0] for patient in cursor.fetchall()]

    print(patientIds)

    print('Please enter a valid patient id')
    print('or enter "exit" to return to the main menu')
    inputId = input()

    while int(inputId) not in patientIds:

        if inputId == 'exit':
            return

        print('Please enter a valid patient id')
        inputId = input()

    results = cursor.callproc('patient_report', [inputId, '@name', '@phone', '@bill', '@procedures', '@prescriptions'])
    print(results)
    
    return

'''
Schedules a staff member for a shift
Input:
    db: database object
    cursor: cursor object

author : skal-chin
'''
def schedule_staff(db, cursor):

    print('Input employee name (REQUIRED)')
    employeeName = input()

    print('Input shift code (REQUIRED)')
    shiftCode = input()

    print('Input shift date (REQUIRED)')
    shiftDate = input()

    results = cursor.callproc('schedule_staff', [employeeName, shiftCode, shiftDate])
    db.commit()

    print('New staff member has been scheduled')
    print(results)

    return