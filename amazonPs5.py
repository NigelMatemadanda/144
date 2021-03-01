# packages needed
from selenium import webdriver
import time
from time import sleep
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.action_chains import ActionChains
import logindata

# import the browser driver
options = webdriver.ChromeOptions()
driver = webdriver.Chrome('Path', options=options)
action = ActionChains(driver)
# put a timer on when the driver is actioned
driver.implicitly_wait(10)
time.sleep(1)
# add your user agent
options.add_argument('--user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, '
                     'like Gecko) Version/14.0.2 Safari/605.1.15')
t = time.time()
driver.set_page_load_timeout(10)

# visit amazon's website
try:
    driver.get('http://www.amazon.co.uk')
except TimeoutException:
    driver.execute_script("window.stop();")
print('Time consuming:', time.time() - t)

# mouse hover to the navigation
firstLevelMenu = driver.find_element_by_xpath('//*[@id="nav-link-accountList"]')
action.move_to_element(firstLevelMenu).perform()
time.sleep(3)
# mouse hover to the drop down navigation
secondLevelMenu = driver.find_element_by_xpath('//*[@id="nav-flyout-ya-signin"]/a/span')
secondLevelMenu.click()
time.sleep(3)
# add in user name from the login data file
signinelement = driver.find_element_by_xpath('//*[@id="ap_email"]')
signinelement.send_keys(logindata.USERNAME)
time.sleep(3)
# mouse clicks continue to login
cont = driver.find_element_by_xpath('//*[@id="continue"]')
cont.click()
time.sleep(3)
# add the password from the login data file
passwordelement = driver.find_element_by_xpath('//*[@id="ap_password"]')
passwordelement.send_keys(logindata.PASSWORD)
time.sleep(3)
# mouse click login
login = driver.find_element_by_xpath('//*[@id="signInSubmit"]')
login.click()
time.sleep(3)

# input the name of the item you want to buy
ps5Search = driver.find_element_by_xpath('//*[@id="twotabsearchtextbox"]')
ps5Search.send_keys("ps5 digital edition")
time.sleep(3)
# click on the search button
search = driver.find_element_by_xpath('//*[@id="nav-search-submit-button"]')
search.click()
time.sleep(3)

# click on the item
goto = driver.find_element_by_xpath(
    '//*[@id="search"]/div[1]/div[2]/div/span[3]/div[2]/div[1]/div/span/div/div/div[2]/div[2]/div/div[1]/div/div/div[1]/h2/a')
goto.click()
time.sleep(3)

# check if the item is available
element = driver.find_element_by_xpath('//*[@id="availability"]')
text = element.text
print(text)
# if the item is out of stock order button is set to False
orderBtn = False

# while the order button is disabled
while not orderBtn:
    # if text is not in stock refresh every 4 seconds
    if text != 'In stock.':
        print("No stock")
        driver.get(driver.current_url)
        sleep(4)
        driver.refresh()

    else:
        print("Stock found!!1")
        # click on buy now
        buyNow = driver.find_element_by_xpath('//*[@id="buy-now-button"]')
        buyNow.click()
        time.sleep(3)
        # confirm your purchase
        confirmPay = driver.find_element_by_xpath('//*[@id="submitOrderButtonId"]/span/input')
        confirmPay.click()
        time.sleep()
        orderBtn = True
        exit(0)
