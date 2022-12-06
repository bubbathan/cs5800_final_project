import json
import mysql.connector

# data = json.load(open('keys.json'))
# mysql.connector.connect(host=data['host'], 
#                         user=data['user'], 
#                         password=data['password'], 
#                         database=data['database']
#                         )


def exitCli():
  print("Goodbye.")
  exit()


# TODO: Get all staff id and put into a list, or lists
# TODO: Check which list the user id is in to determine navigation
def authUser():
  print("Welcome to your Hospital Database Management System.")
  print("Please enter your System ID.")
  sysId = input().upper()

  if sysId == "DOCTOR":
    print("Welcome, Doctor.")
    home()
  elif sysId == "NURSE":
    print("Welcome, Nurse.")
    home()
  else:
    exitCli()


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


def tableInput():
  print("")
  print("Which TABLE do you want to work with?")
  print("1. Staff")
  print("2. Patient")
  print("3. Return")
  print("4. Exit")
  tableInput = input()


# TODO: I split them up so we can seperate patient and staff tables
  if tableInput == "1":
    staffTable()
  elif tableInput == "2":
    print("You have chosen to work with the Patient TABLE.")
  elif tableInput == "3":
    home()
  elif tableInput == "4":
    exitCli()
  else:
    print("Invalid input. Please try again.")
    tableInput()


# TODO: Connect to tables and run the chosen one
# TODO: After a table is selected, print the table as-is
# TODO: If table is changed, print new table after change is made
def staffTable():
  print("")
  print("Please select a staff Table or something")

def patientTable():
  print("")
  print("Please select a patient Table or something")


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
  elif functionInput == "2":
    print("You have chosen to update patient records.")
  elif functionInput == "3":
    print("You have chosen to update patient billing.")
  elif functionInput == "4":
    print("You have chosen to generate a patient report.")
  elif functionInput == "5":
    print("You have chosen to list on-call staff.")
  elif functionInput == "6":
    print("You have chosen to generate procedure performance report.")
  elif functionInput == "7":
    print("You have chosen to schedule staff.")
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