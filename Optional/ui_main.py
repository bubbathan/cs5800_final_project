import json
import mysql.connector

data = json.load(open('./Optional/keys.json'))
mysql.connector.connect(host=data['host'], 
                        user=data['user'], 
                        password=data['password'], 
                        database=data['database']
                        )

print(data)


# TODO: Get all staff id and put into a list, or lists
# TODO: Check which list the user id is in to determine navigation
def authUser():
  print("Welcome, please enter your System ID")
  x = input().upper()
  if x == "DOCTOR":
    print("Welcome, Doctor.")
    home()
  elif x == "NURSE":
    print("Welcome, Nurse.")
    home()
  else:
    print("Invalid System ID. Goodbye.")
    exit()


def home():
  print("Do you want to work with a TABLE or a FUNCTION?")
  x = input().upper()
  print("You have chosen to work with a " + x + ".")
  if x == "TABLE":
    tableInput()
  elif x == "FUNCTION":
    functionInput()
  else:
    print("Please enter a valid input.")
    home()


# TODO: Print table requested
# TODO: List options for each table
def tableInput():
  print("Please enter the name of the TABLE you want to work with or RETURN.")
  print("[TableList]")
  x = input().upper()
  if x == "RETURN":
    home()
  else:
    print("You have chosen to work with the " + x + " TABLE.")

# TODO: Connect to functions and run the chosen one
def functionInput():
  print("Please enter the name of the FUNCTION you want to work with or RETURN.")
  print("[FunctionList]")
  x = input().upper()
  if x == "RETURN":
    home()
  else:
    print("You have chosen to work with the " + x + " FUNCTION.")

authUser()