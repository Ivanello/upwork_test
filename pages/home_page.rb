require_relative 'base_page'
require './pages/freelancer_search_results_page'

class HomePage < BasePage

  #Page elements
  def search_field
    @driver.find_element(:id, 'q')
  end

  def search_source_menu
    @driver.find_element(:class, 'air-icon-arrow-expand')
  end

  def search_source_name(source_name)
    @driver.find_element(:xpath, "//a[contains(text(),'#{source_name}')]")
  end

  #Page actions

  def loaded?
    $logger.info("HomePage: wait to load page")
    @wait.until { @driver.find_element(:class, 'footer-logos').displayed? }
  end

  # 4. Focus onto "Find freelancers"
  def choose_source_to_search(source)
    $logger.info("HomePage: select search source to: '#{source}'")
    search_source_menu.click
    search_source_name(source).click
  end

  # 5. Enter `<keyword>` into the search input right from the dropdown and submit it (click on the magnifying glass
  # button)
  def search(keyword)
    $logger.info("HomePage: search for  #{keyword}")
    search_field.send_keys keyword
    search_field.submit
    FreelancerSearchResultsPage.new(@driver, $logger)
  end
end
