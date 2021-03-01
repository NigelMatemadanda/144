import os
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from twilio.rest import Client
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC

headers = {
    "User-agent": 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) '
                  'Version/13.1.2 Safari/605.1.15 '
}


driver = webdriver.Chrome('/Users/nigelmunar/Desktop/chromedriver')
driver.implicitly_wait(10)

t = time.time()
driver.set_page_load_timeout(10)

try:
    driver.get("https://www.smythstoys.com/uk/en-gb/video-games-and-tablets/playstation-5/playstation-5-consoles"
               "/playstation-5 "
               "-digital-edition-console/p/191430")
except TimeoutException:
    driver.execute_script("window.stop();")
print('Time consuming:', time.time() - t)


buyButton = False

while not buyButton:
    if (driver.find_element_by_id("addToCartButton").is_enabled() == False):
        print("No stock")
        time.sleep(3)
        driver.refresh()
    else:
        addToCartBtn = addButton = driver.find_element_by_id("addToCartButton")
        print("Product added to basket")
        addButton.click()
        buyButton = True
        wait = WebDriverWait(driver, 10)
        wait.until(EC.element_to_be_clickable((By.XPATH, "// *[ @ id = 'showCartPopup']"))).click()
        wait.until(
            EC.element_to_be_clickable((By.XPATH, "//*[@id='cookieLoad']/div/div/div[1]/div[4]/div[1]/button"))).click()
        print("Stock found")
        exit()
