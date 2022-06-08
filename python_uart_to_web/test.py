# this test file will be used to test the functionality of the program
# without having to run the program on a Pi with the hardware attached

"""
This script should remove the serial device requirement listing a few example messages for the user to choose from. 
This user input should then be decoded and instead of opening the web browser, the URL should be printed to the console.

This script should intake a configuration option for the user to choose if they want to run this test in development or production mode 
development will do Input / output via the console 
production will use the actual serial device and Selenium 


Order of operation: 
1: when launched, the script should ask the user if they want to run in development or production mode
2: if the user selects development mode, output the list of options for the user to select to the console 

"""
import os 
import sys




def main():
    mode = getMode()
    if mode == "development":
        print("Development mode selected")
        print("Please select an option from the list below: ")
        print("1: Open the webpage")
        print("2: Close the webpage")
        print("3: Refresh the webpage")
        print("4: Get the webpage URL")
        print("5: Quit")
        user_input = input("Please enter the number of the option you would like to select: ")
        if user_input == "1":
            print("Open the webpage")
        elif user_input == "2":
            print("Close the webpage")
        elif user_input == "3":
            print("Refresh the webpage")
        elif user_input == "4":
            print("Get the webpage URL")
        elif user_input == "5":
            print("Quit")
        else:
            print("Invalid input")
    elif mode == "production":
        print("Production mode selected")
        print("Please select an option from the list below: ")
        print("1: Open the webpage")
        print("2: Close the webpage")
        print("3: Refresh the webpage")
        print("4: Get the webpage URL")
        print("5: Quit")
        user_input = input("Please enter the number of the option you would like to select: ")
        if user_input == "1":
            print("Open the webpage")
        elif user_input == "2":
            print("Close the webpage")
        elif user_input == "3":
            print("Refresh the webpage")
        elif user_input == "4":
            print("Get the webpage URL")
        elif user_input == "5":
            print("Quit")
        else:
            print("Invalid input")
    else:
        getMode()

def getMode():
    print("Please select an option from the list below: ")
    print("1: Development mode")
    print("2: Production mode")
    user_input = input("Please enter the number of the option you would like to select: ")
    if user_input == "1":
        return "development"
    elif user_input == "2":
        return "production"
    else:
        print("Invalid input")
        getMode()


if __name__ == "__main__":
    main()