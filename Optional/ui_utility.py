import mysql.connector.errors as errors

def select_query(cursor, table, select='*', where=None):
    '''
    Input:
        cursor: cursor object
        table: string, name of table
        select: string, columns to select
        where: string, conditions for selection in dictionary form
                i.e. {'id' : 1, 'name' : 'John'}
    '''
    query = f'SELECT {select} FROM {table}'

    if where:
        query += ' WHERE ' + ' AND '.join([f'{column} = {value}' for column, value in where.items()])

    print(query)
    cursor.execute(query)
    return cursor.fetchall()

def insert_query(db, cursor, table, columns, values):
    '''
    Input:
        db: database object
        cursor: cursor object
        table: string, name of table
        columns: list of strings, columns to insert
                i.e. ['id', 'name']
        values: list of tuples, values to insert
                i.e. [1, 'John']
    '''
    query = f'INSERT INTO {table} ({", ".join(columns)}) VALUES ({", ".join(values)})'

    cursor.execute(query)
    db.commit()
    return cursor.lastrowid

def delete_query(db, cursor, table, conditions):
    '''
    Input:
        db: database object
        cursor: cursor object
        table: string, name of table
        conditions: list of tuples, conditions for deletion
                    i.e. {'id' : 1, 'name' : 'John'}
    '''
    query = f'DELETE FROM {table}'
    query += ' WHERE ' + ' AND '.join([f'{column} = {value}' for column, value in conditions.items()])

    try: 
        cursor.execute(query)
        db.commit()

    except errors.IntegrityError:
        print('This deletion violates an Integrity Error')
        return

    return cursor.rowcount
