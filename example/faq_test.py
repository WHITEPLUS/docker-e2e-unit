import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

class FAQ(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Remote(
                command_executor='http://127.0.0.1:4444/wd/hub',
                desired_capabilities=DesiredCapabilities.CHROME)

    def test_faq(self):
        driver = self.driver
        driver.get("https://www.lenet.jp/questions")
        assert "リネット" in driver.title
        elem = driver.find_element_by_name("q")
        elem.clear()
        elem.send_keys("シミ")
        elem.send_keys(Keys.RETURN)
        assert "シミについてのよくあるご質問" in driver.title

    def tearDown(self):
        self.driver.close()

