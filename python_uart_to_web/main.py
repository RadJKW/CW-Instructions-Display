
import time
import json 
from models.coil_properties import CoilProperties
from models.serial_controller import ControlSerial
from models.chrome_controller import ChromeController



def main():
    """
    Main function: 

    
    """
  
    uart = ControlSerial()

    uart.close_port()
    uart.open_port()

    coil = CoilProperties()
    coil.set_div_url()
    coil.key = "NC"

    chrome = ChromeController()
    chrome.open_webpage(coil.div_url)

    while True:
        uart.read_serial()
        coil.edit_coil(uart.data)
        if coil.new_url is True:
            if not chrome.open_webpage(coil.stop_url):
                if not chrome.open_webpage(coil.wnd_type_url):
                    chrome.open_webpage(coil.div_url)



if __name__ == "__main__":
    main()
