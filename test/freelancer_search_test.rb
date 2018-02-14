require 'selenium-webdriver'
require 'test/unit'
require_relative 'base_test'
require_relative '../models/freelancer'
require_relative '../pages/home_page'
require_relative '../pages/freelancer_search_results_page'
require_relative '../pages/freelancer_details_page'


class FreelancerSearchTest < BaseTest
  def test_freelancer_search

    $logger.info("FreelancerSearchTest start")

    home_page = HomePage.new(@driver, @logger)
    assert(home_page.loaded?, "Homepage failed to load")
    home_page.choose_source_to_search("freelancers")

    results_page = home_page.search(@@keyword)
    assert(results_page.loaded?, "Search result page failed to load")

    found_freelancers = results_page.parse_freelancers
    found_freelancers.each do |freelancer|
      freelancer.any_attributes_contain(@@keyword)
    end

    results_page.check_attributes_contain(@@keyword)
    random_freelancer_number = rand(10)
    details_page = results_page.open_freelancer_by_number(random_freelancer_number)
    assert(details_page.loaded?, "Freelancer details page failed to load")
    details_page.open_more_details
    random_freelancer = details_page.parse_freelancer_details

    assert(details_page.compare_random_fr_with_found_fr(found_freelancers[random_freelancer_number]),
           "Detailed page DIDN'T contains all data from search page")
    assert(random_freelancer.any_attributes_contain(@@keyword), "Random freelancer details did't have '#{@@keyword}")
  end
end


