def welcomeMessage():
  print("Welcome! Do you want to work with a TABLE or a FUNCTION?")
  x = input().upper()
  print("You have chosen to work with a " + x + ".")
  if x == "TABLE":
    tableInput()
  elif x == "FUNCTION":
    functionInput()
  else:
    print("Please enter a valid input.")
    welcomeMessage()

def tableInput():
  print("Please enter the name of the TABLE you want to work with or RETURN.")
  print("[TableList]")
  x = input().upper()
  if x == "RETURN":
    welcomeMessage()
  else:
    print("You have chosen to work with the " + x + " TABLE.")

def functionInput():
  print("Please enter the name of the FUNCTION you want to work with or RETURN.")
  print("[FunctionList]")
  x = input().upper()
  if x == "RETURN":
    welcomeMessage()
  else:
    print("You have chosen to work with the " + x + " FUNCTION.")

welcomeMessage()