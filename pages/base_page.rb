# require 'selenium-webdriver'

class BasePage
  def initialize(driver, logger)
    @driver = driver
    @wait   = Selenium::WebDriver::Wait.new(timeout: 15)
    @logger = logger
  end
end
