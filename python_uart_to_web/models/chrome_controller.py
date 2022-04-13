import re
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options


class ChromeController:
    def __init__(self):
        self.options = Options()
        self.options.add_argument("--kiosk")
        self.options.add_argument("--incognito")
        self.options.add_argument("--disable-notifications")
        self.options.add_experimental_option("excludeSwitches", ["enable-automation"])
        self.options.add_experimental_option("useAutomationExtension", False)
        self.driver = webdriver.Chrome(options=self.options)
        self.driver.implicitly_wait(2)
    
    def __del__(self):
        self.driver.quit()
    
    def __exit__(self, exc_type, exc_value, traceback):
        self.driver.quit()
    
    def __str__(self):
        return "Chrome Controller"
    
    def __repr__(self):
        return "Chrome Controller"

    def open_webpage(self, url):
        try:
            self.driver.get("{}".format(url))
        except Exception as e:
            print("Selenium Erro: {}".format(e))
            return False
        # print(str(url))
        self.driver.implicitly_wait(2)
        check_error = self.driver.current_url

        if re.search("Error", check_error):
            element = self.driver.find_element_by_xpath("//h1")
            self.driver.execute_script(
                "arguments[0].innerText = 'Server Error in *WindingPractices* Application -- *****Program Message: Redirecting to [Most Relavent Directory] in 5 seconds....*****'",
                element,
            )
            time.sleep(5)

            self.driver.back()
            return False
        print(self.driver.current_url)
        return True

    def close_webpage(self):
        self.driver.close()

    def refresh_webpage(self):
        self.driver.refresh()
    
    def get_webpage_url(self):
        return self.driver.current_url


# def setup_webDriver():
#     options = Options()
#     options.add_argument("--kiosk")
#     options.add_argument("--incognito")
#     options.add_argument("--disable-notifications")
#     options.add_experimental_option("excludeSwitches", ["enable-automation"])
#     options.add_experimental_option("useAutomationExtension", False)
#     #driver = webdriver.Chrome(executable_path=r"/usr/bin/chromedriver")
#     driver = webdriver.Chrome(options=options)
#     return driver


# def open_webpage(url, driver):
#     try:
#         driver.get("{}".format(url))
#     except Exception as e:
#         print("Selenium Erro: {}".format(e))
#         return False
#     # print(str(url))
#     driver.implicitly_wait(2)
#     check_error = driver.current_url

#     if re.search("Error", check_error):
#         element = driver.find_element_by_xpath("//h1")
#         driver.execute_script(
#             "arguments[0].innerText = 'Server Error in *WindingPractices* Application -- *****Program Message: Redirecting to [Most Relavent Directory] in 5 seconds....*****'",
#             element,
#         )
#         time.sleep(5)

#         driver.back()
#         return False
#     print(driver.current_url)
#     return True

# self.options.add_argument(
#     "--kiosk"
#     "--incognito"
#     "--noerrdialogs"
#     "--disable-infobars"
#     "--disable-notifications"
#     "--ignore-gpu-blacklist"
#     "--disable-extensions"
#     "--use-gl=egl"
#     "--enable-native-gpu-memory-buffers"
#     "enable-accelerated-2d-canvas"
#     "--force-gpu-rasterization"
#     "--cast-app-background-color=000000ff"
#     "--default-background-color=000000ff"
# )
# self.options.add_argument("--incognito")
# self.options.add_argument("--disable-notifications")
