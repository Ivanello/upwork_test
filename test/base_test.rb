require 'selenium-webdriver'
require 'test/unit'
require 'logger'


class BaseTest < Test::Unit::TestCase

  @@browser = :ARGV[0]
  @@keyword = ARGV[1]
  # for debugging in Rubymine
  # TODO: move browser, keyword parameters to environment variable
  # @@browser = :ff
  # @@keyword = 'angular'
  @@base_url = 'http://upwork.com'

  def setup

    #its possible to configure logger here
    $logger = Logger.new(STDOUT)
    # $logger = Logger.new(".//logs//#{Time.new.strftime('%Y_%m_%d_%H_%M_%S')}_#{@@browser}.log")

    $logger.info("Add ./bin folder with webdrivers to PATH environment variable")
    ENV['PATH']+=":"+Dir.pwd+'/bin'

    $logger.info("Keyword to search is: '#{@@keyword}'")
    $logger.info("Starting browser '#{@@browser}'")

    if [:chrome, :firefox, :ff, :phantomjs, :safari].include? @@browser
      @driver = Selenium::WebDriver.for @@browser
    else
      @driver = Selenium::WebDriver.for :chrome
    end

    @@wait = Selenium::WebDriver::Wait.new(:timeout => 20)

    $logger.info("Browser: clear cookie")
    @driver.manage.delete_all_cookies
    $logger.info("Browser: maximize window")
    @driver.manage.window.maximize
    $logger.info("Browser: open #{@@base_url}")
    @driver.get @@base_url
  end

  def teardown
    @driver.quit
    $logger.close
  end
end
