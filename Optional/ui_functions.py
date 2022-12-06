def register_patient(cursor, id, name, ssn, address='NULL', phone='NULL', insuranceId='NULL', pcp='NULL'):
    '''
    Input:
        cursor: cursor object
        id: string, patient id
        name: string, patient name
        ssn: string, patient ssn
        address: string, patient address
        phone: string, patient phone
        insuranceId: string, patient insurance id
        pcp: string, patient pcp
    '''
    query = f'CALL register_patient({id}, {name}, {ssn}, {address}, {phone}, {insuranceId}, {pcp})'
    cursor.execute(query)
    return cursor.fetchall()

def patient_report(cursor, patientId):
    '''
    Input:
        cursor: cursor object
        patientId: string, patient id
    '''
    query = f'CALL patient_report({patientId})'
    cursor.execute(query)
    return cursor.fetchall()

def schedule_staff(cursor, employeeName, shiftCode, shiftDate):
    '''
    Input:
        cursor: cursor object
        employeeName: string, employee name
        shiftCode: string, shift code
        shiftDate: string, shift date
    '''
    query = f'CALL schedule_staff({employeeName}, {shiftCode}, {shiftDate})'
    cursor.execute(query)
    return cursor.fetchall()