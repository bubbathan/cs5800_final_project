import json
import mysql.connector

from ui_functions import *
from ui_utility import *

data = json.load(open('keys.json'))
db = mysql.connector.connect(host=data['host'], 
                        user=data['user'], 
                        password=data['password'], 
                        database=data['database']
                        )

# Cursor is used to execute queries and retrieve data
# dbFunctions is a dictionary of functions that can be called
cursor = db.cursor()
currentUser = None
dbFunctions = {
  "1" : "Update Patient Billing",
  "2" : "Update Patient Records",
  "3" : "Check Medicine Inventory",
  "4" : "Check Room Availability",
  "5" : "Check On-call Doctors",
  "6" : "Patient Registration",
  "7" : "Generate Patient Report",
  "8" : "Schedule Staff",
}

cursor.execute("SELECT employeeId FROM doctor")
doctorIds = [item[0] for item in cursor.fetchall()]

cursor.execute("SELECT employeeId FROM nurse")
nurseIds = [item[0] for item in cursor.fetchall()]


# Exits the program
def exitCli():
  print("Goodbye.")
  exit()

# Authenticates the user
def authUser():
  print("Welcome to your Hospital Database Management System.")
  print("Please enter your System ID.")

  sysId = input()

  if not sysId.isdigit():

    if sysId.lower() == "exit":
      exitCli()
    
    else:
      print("Invalid input. Please try again.")
      authUser()

  if int(sysId) in doctorIds:
    print("Welcome, Doctor.")
    home()
  elif int(sysId) in nurseIds:
    print("Welcome, Nurse.")
    home()
  else:
    exitCli()

# Home page
def home():
  print("")
  print("Do you want to work with a TABLE or a FUNCTION?")
  print("1. Table")
  print("2. Function")
  print("3. Exit")
  choice = input()

  if choice == "1":
    tableInput()
  elif choice == "2":
    functionInput()
  elif choice == "3":
    exitCli()
  else:
    print("Invalid input. Please try again.")
    home()



# Which type of table to work with
def tableInput():
  print("")
  print("Which TABLE do you want to work with?")
  print("1. Staff")
  print("2. Patient")
  print("3. Return")
  print("4. Exit")
  tableIn = input()


# TODO: I split them up so we can seperate patient and staff tables
  if tableIn == "1":
    print("You have chosen to work with the Staff TABLE.")
    staffTable()
  elif tableIn == "2":
    print("You have chosen to work with the Patient TABLE.")
    patientTable()
  elif tableIn == "3":
    home()
  elif tableIn == "4":
    exitCli()
  else:
    print("Invalid input. Please try again.")
    tableInput()

# Displays the list of tables to work with as per tableList
def tableSelection(tableList):
  print("")
  print("Which TABLE do you want to work with?")

  for table in tableList:
    print(table.upper())

  print("Choose A table or type '3' to go back to the main menu.")
  tableInput = input()

  if tableInput.lower() == "exit":
    exitCli() 
  elif tableInput.lower() == "3":
    home()
  elif tableInput.lower() in tableList:
    print("You have chosen to work with the " + tableInput.upper() + " TABLE.")
    print("What would you like to do?")
    print("1. View Table")
    print("2. Add to Table")
    print("3. Delete from Table")
    print("4. Go back to the main menu")

    tableChoice = input()

    if tableChoice == "1":
      showTable(tableInput)
    elif tableChoice == "2":
      addTable(tableInput)
    elif tableChoice == "3":
      deleteTable(tableInput)
    elif tableChoice == "4":
      home()
    else:
      print("Invalid input. Please try again.")
      tableInput()

# TODO: Connect to tables and run the chosen one
# TODO: After a table is selected, print the table as-is
# TODO: If table is changed, print new table after change is made
'''
Operations to perform a select query on a table. Allows
for specific columns to be selected and conditions to be
added to the query.
MINIMALLY TESTED

Parameters:
  table: The table to be queried

author: @skal-chin
'''
def showTable(table):

  # Outputs the columns of the table
  cursor.execute(f'describe {table}')
  columns = [column[0] for column in cursor.fetchall()]
  print(" | ".join(columns))

  print('Press enter to see the whole table or')
  print('type the columns you want to see separated by commas or')
  print('exit to go back to the main menu.')
  columnsInput = input()

  if columnsInput == "exit":
    home()

  # perfroms SELECT * FROM TABLE
  if columnsInput == '':
    results = select_query(cursor, table)
    for result in results:
      print(result)
    tableInput()

  # Checks if the input is a valid column
  trueColumns = [c in columns for c in columnsInput.split(',')]

  if False in trueColumns:
    print("Invalid input. Please try again.")
    showTable(table)
  
  print(f'Are there any conditions for {columnsInput}? (y/n)')
  conditionInput = input()

  # Takes conditional input
  if conditionInput.lower() == 'y':
    conditionDict = {}

    for column in columnsInput.split(','):
      print(f'What is the condition for {column}?')
      newCondition = input()

      # Empty condition does not add a condition to the query
      if newCondition == '':
        continue

      conditionDict[column] = newCondition
    
    results = select_query(cursor, table, columnsInput, conditionDict)
    for result in results:
      print(result)
    tableInput()

  # Performs SELECT columns FROM TABLE
  elif conditionInput.lower() == 'n':
    results = select_query(cursor, table, columnsInput)
    for result in results:
      print(result)
    tableInput()

  else:
    print("Invalid input. Please try again.")
    showTable(table)


'''
Performs operations to add a row to a table.
MINIMALLY TESTED

Parameters:
  table: The table to add a row to

author: @skal-chin
'''
def addTable(table):

  cursor.execute(f'describe {table}')
  data = cursor.fetchall()

  columnNames = []
  nullConstraints = []
  inputs = []
  columnsUsed = []

  for column in data:
    columnNames.append(column[0])
    nullConstraints.append('YES' if column[2] == 'NO' else 'NO')

  print('{:<20} {:<10}'.format('Column Name', 'Required'))
  for i in range(len(columnNames)):

    required = 'NOT REQUIRED' if nullConstraints[i] == 'NO' else 'REQUIRED'

    print(f'Enter value for {columnNames[i].upper()} ({required}):')
    valInput = input()

    if valInput != '':
      columnsUsed.append(columnNames[i])

      if not valInput.isdigit():
        valInput = f'"{valInput}"'
      inputs.append(valInput)
  rowId = insert_query(db, cursor, table, columnsUsed, inputs)

  print(f'Row {rowId} has been added to {table.upper()}')

  home()

'''
Performs operations to delete a row from a table.
MINIMALLY TESTED

Parameters:
  table: The table to delete a row from

author: @skal-chin
'''
def deleteTable(table):
  cursor.execute(f'describe {table}')
  columns = [column[0] for column in cursor.fetchall()]
  conditions = {}

  print(f'Enter the column names and values of the row you want to delete from {table.upper()}.')
  print('i.e COLUMN_NAME, VALUE')
  print('Enter delete to delete the row.')

  while True:
    userInput = input()

    if userInput.lower() == 'delete':
      break

    condition = userInput.replace(' ', '').split(',')

    if condition[0] not in columns:
      print('Invalid column name. Please try again.')
      continue

    conditions[condition[0]] = condition[1] if condition[1].isdigit() else f'"{condition[1]}"'

  rows = delete_query(db, cursor, table, conditions)
  print(f'You deleted {rows} rows in {table.upper()}')

  home() 

  

def staffTable():
  tableList = [
  'staff',
  'doctor',
  'nurse',
  'surgeon',
  'specialist',
  'general',
  'leads',
  'prescribes',
  'treats',
  'shift',
  'isscheduled',
  'visit',
  'worksin',
  'workswith',
  ]

  tableSelection(tableList)

def patientTable():
  tableList = [
    'patient',
    'diagnosed',
    'prescribes',
    'treat',
    'stays',
    'visit',
  ]

  tableSelection(tableList)


# TODO: Connect to functions and run the chosen one
# TODO: Some functions will require further input, like which patient to generate a report on
# TODO: Other function will just print information
def functionInput():
  print("")
  print("Which FUNCTION do you want to run?")
  print("---Patient Functions---")
  print("1. Register new patient")
  print("2. Update existing patient records")
  print("3. Update patient billing")
  print("4. Generate patient report")

  print("---Staff Functions---")
  print("5. List on-call staff")
  print("6. Generate procedure performance report")
  print("7. Schedule staff")

  print("---Building Functions---")
  print("8. Check medicine stock")
  print("9. Print available rooms")
  
  print("---Other---")
  print("10. Return")
  print("11. Exit")
  functionInput = input()

  if functionInput == "1":
    print("You have chosen to register a new patient.")
    register_patient(db, cursor)

  elif functionInput == "2":
    print("You have chosen to update patient records.")
  elif functionInput == "3":
    print("You have chosen to update patient billing.")
  elif functionInput == "4":
    print("You have chosen to generate a patient report.")
    patient_report(cursor)

  elif functionInput == "5":
    print("You have chosen to list on-call staff.")
  elif functionInput == "6":
    print("You have chosen to generate procedure performance report.")
  elif functionInput == "7":
    print("You have chosen to schedule staff.")
    schedule_staff(db, cursor)
    
  elif functionInput == "8":
    print("You have chosen to check medicine stock.")
  elif functionInput == "9":
    print("You have chosen to print available rooms.")
  elif functionInput == "10":
    home()
  elif functionInput == "11":
    exitCli()
  else:
    print("Invalid input. Please try again.")
    functionInput()




authUser()