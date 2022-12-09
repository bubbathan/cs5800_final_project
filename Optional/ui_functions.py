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
    name = f'"{name}"'

    print('Input patient ssn (REQUIRED)')
    ssn = input()
    ssn = f'"{ssn}"'

    print('Input patient address (OPTIONAL)')
    address = input()
    if address:
        address = f'"{address}"'
    else:
        address = 'NULL'

    print('Input patient phone (OPTIONAL)')
    phone = input()
    if phone:
        phone = f'"{phone}"'
    else:
        phone = 'NULL'

    print('Input patient insurance id (OPTIONAL)')
    insuranceId = input()
    if not insuranceId:
        insuranceId = 'NULL'

    print('Input patient pcp (OPTIONAL)')
    pcp = input()
    if pcp:
        pcp = f'"{pcp}"'
    else:
        pcp = 'NULL'

    query = f'CALL register_patient({id}, {name}, {ssn}, {address}, {phone}, {insuranceId}, {pcp})'
    cursor.execute(query)
    db.commit()

    print(cursor.fetchall())

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

    print('Please enter a valid patient id')
    print('or enter "exit" to return to the main menu')
    inputId = input()

    while inputId not in patientIds:

        if inputId == 'exit':
            return

        print('Please enter a valid patient id')
        inputId = input()

    query = f'CALL patient_report({inputId})'
    cursor.execute(query)
    print(cursor.fetchall())
    
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
    employeeName = f'"{employeeName}"'

    print('Input shift code (REQUIRED)')
    shiftCode = input()

    print('Input shift date (REQUIRED)')
    shiftDate = input()
    shiftDate = f'"{shiftDate}"'

    query = f'CALL schedule_staff({employeeName}, {shiftCode}, {shiftDate})'
    cursor.execute(query)
    db.commit()

    print(cursor.fethcall())

    return