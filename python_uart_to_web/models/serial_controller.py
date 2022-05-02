import datetime
import serial
from os import path


class ControlSerial:
    def __init__(self):
        self.port = "/dev/ttyUSB0"
        self.baudrate = 9600
        self.filePath = path.dirname(path.abspath(__file__)) + "/logs/serial_log.txt"
        self.data = ""
        self.data_received = False
        self.ser = serial.Serial()
        self.open_port()
        return
    
    def __del__(self):
        self.close_port()
        return
    
    def __str__(self):
        return "Serial port {}".format(self.port)


    

    # ser = serial.Serial()
    # ser.parity = serial.PARITY_NONE
    # ser.stopbits = serial.STOPBITS_ONE
    # ser.bytesize = serial.EIGHTBITS
    # ser.timeout = 1
    # data = ""
    # data_received = False
    # # this Path needs to be obtained from the Operating System
    # filePath = path(r"/home/parallels/Desktop/Z80_Doc_Display.txt")

    # # __INIT__
    # #
    # def __init__(self, port, baudrate):

    #     self.port = port
    #     self.baudrate = baudrate

    #     self.filePath.touch(exist_ok=True)

    #     with (open(self.filePath, "a")) as fw0:
    #         fw0.write("----------------------------------")
    #         fw0.write(datetime.today().strftime("%Y-%m-%d" + "," "%H:%M:%S"))
    #         fw0.write("----------------------------------" + "\n")
    #         fw0.close()
    #     print(
    #         "Script Started: "
    #         + datetime.today().strftime("%Y-%m-%d" + "," "%H:%M:%S")
    #         + "\n"
    #     )
        # self.rx_msg = ""

    def open_port(self):
        self.ser.port = self.port
        self.ser.baudrate = self.baudrate
        self.filePath.touch(exist_ok=True)
        
        if not self.ser.port:
            self.serial_error()

        try:
            self.ser.open()
            return "Serial port {} succesffuly opened!".format(self.port)
        except Exception as e:
            # create the file if it doesn't exist
            with (open(self.filePath, "a")) as fw1:
                fw1.write(str(e) + "<\n")
                fw1.close()
            print("Error: Serial Open " + str(e))
            self.ser.reset_input_buffer()
            return

    def close_port(self):
        self.ser.close()
        return "Serial port {} closed".format(self.port)

    def serial_error(self):
        return "Cannot open port {}".format(self.port)

    def read_serial(self):
        self.data_received = False
        while self.data_received is False:
            self.data = ""
            rx_data = self.ser.readline()
            utf8_data = rx_data.decode("utf8")

            if len(utf8_data) > 1:
                # print(utf8_data)
                self.data = utf8_data
                self.data_received = True
                self.log_serial()
        return

    def log_serial(self):
        with (open(self.filePath, "a")) as fw1:
            currentTime = datetime.today()
            # fw2.write(currentTime.strftime(
            #    '%H:%M:%S') + '>' + hex_data + '<\n')
            fw1.write(currentTime.strftime("%H:%M:%S") + ">" + self.data + "<")
            fw1.close()
        print(currentTime.strftime("%H:%M:%S") + ">  " + self.data + "<")
        return
