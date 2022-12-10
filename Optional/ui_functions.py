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
    cursor: cursor object

author : skal-chin
'''
def patient_report(cursor):

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

'''
Shows the available rooms
Input:
    cursor: cursor object

author : skal-chin
'''
def get_available_rooms(cursor):

    cursor.execute('SELECT roomNumber FROM room WHERE availability = 1')
    results = cursor.fetchall()

    for room in results:
        print(room)

    return

'''
Retrieves all of the information on medications
Input:
    cursor: cursor object

author : skal-chin
'''
def get_medications(cursor):

    cursor.execute('SELECT * FROM medication')
    results = cursor.fetchall()
    
    for medication in results:
        print(medication)

    return

'''
Retrieves all of the doctors currently on-call
Input:
    cursor: cursor object

author : skal-chin
'''

def get_on_call_doctors(cursor):
    
    cursor.execute('SELECT employeeName FROM staff WHERE employeeId IN (SELECT employeeId FROM doctor WHERE onCall = 1)')
    results = cursor.fetchall()
    
    for doctor in results:
        print(doctor[0])

    return

'''
Changes the cost of a medication
Input:
    db: database object
    cursor: cursor object

author : skal-chin
'''
def change_medication_cost(db, cursor):

    cursor.execute('SELECT name FROM medication')
    medicationNames = [medication[0] for medication in cursor.fetchall()]
    
    print('Input medication name (REQUIRED)')
    medicationName = input().upper()

    while medicationName not in medicationNames:
        print('Please enter a valid medication name')
        medicationName = input().upper()

    print('Input new cost (REQUIRED)')
    cost = input()

    cursor.execute(f'SELECT code FROM medication WHERE name = "{medicationName}"')
    medicationCode = cursor.fetchone()

    results = cursor.callproc('set_medication_cost', [medicationCode[0], cost])
    db.commit()

    print('Medication cost has been changed')
    print(results)

    return

'''
Changes the cost of a procedure
Input:
    db: database object
    cursor: cursor object

author : skal-chin
'''
def change_procedure_cost(db, cursor):

    cursor.execute('SELECT name FROM mprocedure')
    procedureNames = [procedure[0] for procedure in cursor.fetchall()]
        
    print('Input procedure name (REQUIRED)')
    procedureName = input().upper()

    while procedureName not in procedureNames:
        print('Please enter a valid procedure name')
        procedureName = input().upper()

    print('Input new cost (REQUIRED)')
    cost = input()

    cursor.execute(f'SELECT code FROM mprocedure WHERE name = "{procedureName}"')
    procedureCode = cursor.fetchone()

    results = cursor.callproc('set_procedure_cost', [procedureCode[0], cost])
    db.commit()

    print('Procedure cost has been changed')
    print(results)

    return

'''
Updates the patient information
Input:
    db: database object
    cursor: cursor object

author : skal-chin
'''
def update_patient_info(db, cursor):

    print('Input patient id (REQUIRED)')
    patientId = input()

    print('Input new patient name (REQUIRED)')
    name = input()

    print('Input new patient ssn (REQUIRED)')
    ssn = input()

    print('Input new patient address (OPTIONAL)')
    address = input()
    if not address:
        address = None

    print('Input new patient phone (OPTIONAL)')
    phone = input()
    if not phone:
        phone = None

    print('Input new patient insurance id (OPTIONAL)')
    insuranceId = input()
    if not insuranceId:
        insuranceId = None

    print('Input new patient pcp (OPTIONAL)')
    pcp = input()
    if not pcp:
        pcp = None

    results = cursor.callproc('update_patient', [patientId, name, ssn, address, phone, insuranceId, pcp])
    db.commit()

    print('Patient information has been updated')
    print(results)

    return