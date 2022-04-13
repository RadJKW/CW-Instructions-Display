from dataclasses import dataclass
from typing import ClassVar




@dataclass
class CoilProperties:
    key: str = ""
    wnd_type: str = ""
    wnd_material: str = ""
    wnd_stop: str = ""
    prev_stop: str = ""
    coil_num: str = ""
    prev_coil_num: str = ""
    division: str = "1"
    mat_width: str = ""
    stop_url: str = ""
    div_url: str = ""
    wnd_type_url: str = ""
    new_url: bool = True
    ignore_codes: ClassVar[list] = ["LE", "ALE", "TT", "ATT", "TS", "ATS", "TB", "ATB"]
    prev_msg: ClassVar[str] = ""
    base_url: ClassVar[
        str
    ] = "http://svr-webint1/WindingPractices/Home/Display?div=D{}&stop={}"
    startup_url: ClassVar[
        str
    ] = "http://svr-webint1/WindingPractices/Home/Display?div=D1&stop=NC"

    def __eq__(self, other):
        return self.wnd_stop == other.prev_stop

    def delete_coil(self):
        tempVar = self.coil_num
        self.__init__()
        self.prev_coil_num = tempVar
        return

    def show_coil(self):
        print(
            f"Coil Number: {self.coil_num}\n"
            + f"Division: {self.division}\n"
            + f"Winding: {self.wnd_type}\n"
            + f"Material: {self.wnd_material}\n"
            + f"Width: {self.mat_width}\n"
            + f"Code: {self.key}"
        )

    def set_stop_url(self):
        print("Stop to set: {}".format(self.wnd_stop))
        print("Prev Stop: {}".format(self.prev_stop))
        stop_prev = self.prev_stop
        if self.wnd_stop == stop_prev:
            
            self.new_url = False
            print("URL DUPLICATE")
            return
        self.prev_stop = self.wnd_stop
        self.stop_url = self.base_url.format(self.division, self.wnd_stop)
        self.new_url = True
        return

    def set_wnd_type_url(self):
        self.wnd_type_url = self.base_url.format(self.division, self.wnd_type)
        return

    def set_div_url(self):
        self.div_url = self.base_url.format(self.division, "")
        return

    def edit_coil(self, uart_str):

        if uart_str == self.prev_msg:
            self.new_url = False
            return

        self.prev_msg = uart_str
        lst_data = uart_str.split(",")
        list_len = len(lst_data)
        if any(target in ("RS") for target in lst_data):
            lst_data[0] = "DE"
            print("Changed 'RS' -> 'DE'")
            self.set_stop_url()
            return

        if list_len == 4:
            self.key = lst_data[0]
            self.wnd_type = lst_data[1]
            self.wnd_material = lst_data[2]
            self.mat_width = lst_data[3]
            self.wnd_stop = lst_data[1]
            self.set_stop_url()
            self.set_wnd_type_url()
            return

        if list_len == 3:
            if lst_data[1] == self.coil_num:
                # do nothing
                # this means the z80 was reset
                print("Coil is the same")
                self.new_url = False
                return
            self.delete_coil()
            self.key = lst_data[0]
            self.coil_num = lst_data[1]
            self.division = lst_data[2]
            self.set_div_url()
            self.wnd_stop = "NC"
            self.set_stop_url()
            print(
                "Deleted Coil: {}\n".format(self.prev_coil_num)
                + "Created Coil: {}".format(self.coil_num)
            )
            return True

        if list_len == 1:
            tmp_str = lst_data[0]
            print("Temp String: {}".format(tmp_str))
            str_len = len(tmp_str)
            print("String length: {}".format(str_len))
            if str_len == 4:
                self.wnd_stop = tmp_str[1:]
                print("Stop Code: {}".format(self.wnd_stop))
            else:
                self.wnd_stop = tmp_str

            if any(target in self.wnd_stop for target in self.ignore_codes):
                print("Code Ignored: {}".format(self.wnd_stop))
                self.new_url = False
                return
            self.set_stop_url()
            return True

        return False

    def log_coil(self):
 
        pass

 

    def get_hv_metal(self):
        pass