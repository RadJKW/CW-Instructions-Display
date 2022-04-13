
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


# create a function for mqtt that will create a json object from the coil properties attributes
# and send it to the mqtt broker

def build_json(coil):
    """
    Build a json object from the coil properties attributes
    """
    json_obj = {
        "key" : coil.key,
        "wnd_type" : coil.wnd_type,
        "wnd_material" : coil.wnd_material,
        "wnd_stop" : coil.wnd_stop,
        "prev_stop" : coil.prev_stop,
        "coil_num" : coil.coil_num,
        "prev_coil_num" : coil.prev_coil_num,
        "division" : coil.division,
        "mat_width" : coil.mat_width,
        "stop_url" : coil.stop_url,
        "div_url" : coil.div_url,
        "wnd_type_url" : coil.wnd_type_url,
        "new_url" : coil.new_url,
        "ignore_codes" : coil.ignore_codes,
        "prev_msg" : coil.prev_msg,
        "base_url" : coil.base_url,
        "startup_url" : coil.startup_url

    }
    return json_obj



if __name__ == "__main__":
    main()
