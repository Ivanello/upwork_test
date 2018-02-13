require_relative 'base_page'

class FreelancerDetailsPage < BasePage

  #Page elements
  def more_details_link
    @driver.find_elements(:xpath, "//div[@id='optimizely-header-container-default']//a[contains(text(), 'more')]")
  end

  def freelancer_name
    @driver.find_element(:xpath, "//div[@id='optimizely-header-container-default']//span[@itemprop='name']")
  end

  def freelancer_title
    @driver.find_element(:xpath, "//div[@id='optimizely-header-container-default']//span[contains(@class, 'fe-job-title')]/span[1]")
  end

  def freelancer_skils
    @driver.find_elements(:xpath, "//div[@class='up-active-container']//div[contains(@class, 'o-profile-skills')]/a")
  end

  def freelancer_description
    @driver.find_element(:xpath, "//div[@id='optimizely-header-container-default']//p[@itemprop='description']")
  end


  #Page actions
  def loaded?
    $logger.info("FrDetailsPage: wait to load page")
    @wait.until {@driver.find_element(:xpath, "//div[@id='optimizely-header-container-default']//span[@itemprop='name']").displayed?}
  end

  def open_more_details
    if more_details_link.any?
      $logger.info("FrDetailsPage: open more details")
      more_details_link[0].click
    end
  end

  def parse_freelancer_details
    $logger.info("FrDetailsPage: parse freelancer")
    @freelancer = (Freelancer.new(
        freelancer_name.text,
        freelancer_title.text,
        freelancer_description.text,
        freelancer_skils.map(&:text)
    ))
    @freelancer
  end

  def check_freelancer_attributes_contain(kwd)
    @freelancer.check_attributes_contain(kwd)
  end

  def compare_random_fr_with_found_fr(found_freelancer)
      $logger.info("FrDetailsPage: comparing attributes of two freelancers")

      name_eql = @freelancer.name == found_freelancer.name
      title_eql = @freelancer.title == found_freelancer.title
      skills_contains = (found_freelancer.skills - @freelancer.skills).empty?
      matches = (title_eql and name_eql and skills_contains)

      $logger.info("Freelancer: Title eql?: #{!!title_eql}")
      $logger.info("Freelancer: Description eql?: #{!!name_eql}")
      $logger.info("Freelancer: Skills eql?: #{!!skills_contains}")

      $logger.info("Freelancer: Random Name: #{@freelancer.name}")
      $logger.info("Freelancer: Found Name: #{found_freelancer.name}")
      $logger.info("Freelancer: Random Title: #{@freelancer.title}")
      $logger.info("Freelancer: Found Title: #{found_freelancer.title}")
      $logger.info("Freelancer: Random Skills: #{@freelancer.skills}")
      $logger.info("Freelancer: Found Skills: #{found_freelancer.skills}")

      $logger.info("No matches!") if !matches
      $logger.info("\s")
      matches

  end






end