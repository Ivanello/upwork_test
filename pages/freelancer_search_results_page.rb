require_relative 'base_page'
require './pages/freelancer_details_page'

class FreelancerSearchResultsPage < BasePage
  #Page elements

  def all_freelancers_block
    @driver.find_elements(:xpath, '//section[@data-qa="freelancer"]')
  end

  # Page Actions

  def loaded?
    $logger.info("FrSearchResultsPage: wait to load page")
    @wait.until { @driver.find_element(:id, "oContractorResults").displayed? }
    #Added for firefox, DOM  refreshes after loading
    sleep(3)
  end

  def parse_freelancers
    $logger.info("FrSearchResultsPage: parsing freelancers")
    @freelancers=[]
    all_freelancers_block.each do |fr|
      @freelancers.push(Freelancer.new(
        fr.find_element(:class, 'freelancer-tile-name').text,
        fr.find_element(:class, 'freelancer-tile-title').text,
        if fr.find_elements(:class, 'freelancer-tile-description').any?
          then fr.find_element(:class, 'freelancer-tile-description').text else "" end,
        fr.find_elements(:class, 'o-tag-skill').map(&:text)
      ))
    end
    return @freelancers
  end

  def check_attributes_contain(kwd)
    @freelancers.each do |freelancer|
      freelancer.check_attributes_contain(kwd)
    end
  end

  # this method help us avoid agencies profiles
  def get_random_freelancer(freelancers_list)
    begin
      random = rand(0..freelancers_list.size-1)
      puts (random)
    end while all_freelancers_block[random].find_element(:class, "freelancer-tile-name").attribute("href").include? "company"
    random
  end

  #this method hepls us to open jusn freelancer profile mot agenies
  def open_freelancer_by_number(number_of_freelancer)
    $logger.info("FrSearchResultsPage: open freelancer ##{number_of_freelancer} in list")
    all_freelancers_block[number_of_freelancer].find_element(:xpath, './/a[contains(@href,"/o/profiles/users/")]').click
    FreelancerDetailsPage.new(@driver, $logger)
  end


end
