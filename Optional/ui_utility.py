def select_query(cursor, table, select='*', where=None):
    '''
    Input:
        cursor: cursor object
        table: string, name of table
        select: string, columns to select
        where: string, conditions for selection
                i.e. [('id', 1), ('name', 'John')]
    '''
    query = f'SELECT {select} FROM {table}'

    if where:
        query += ' WHERE ' + ' AND '.join([f'{column} = {value}' for column, value in where])

    cursor.execute(query)
    return cursor.fetchall()

def insert_query(cursor, table, values):
    '''
    Input:
        cursor: cursor object
        table: string, name of table
        values: list of tuples, values to insert
                i.e. [(1, 'John')]
    '''
    cursor.execute('SHOW COLUMNS FROM ' + table)
    columns = [column[0] for column in cursor.fetchall()]

    query = f'INSERT INTO {table} ({", ".join(columns)}) VALUES ({values})'

    cursor.execute(query)
    return cursor.lastrowid

def delete_query(cursor, table, conditions):
    '''
    Input:
        cursor: cursor object
        table: string, name of table
        conditions: list of tuples, conditions for deletion
                    i.e. [('id', 1), ('name', 'John')]
    '''
    query = f'DELETE FROM {table} WHERE'
    query += ' WHERE ' + ' AND '.join([f'{column} = {value}' for column, value in conditions])

    cursor.execute(query)
    return cursor.rowcount
