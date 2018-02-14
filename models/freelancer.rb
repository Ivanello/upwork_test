# Class presents a freelancer

class Freelancer

  attr_accessor :name, :title, :description, :skills

  def initialize(name = '', title = '', description = '', skills = [''])
    @name = name
    @title = title
    @description = description
    @skills = skills
  end

  # 7. Make sure at least one attribute (title, overview, skills, etc) of each item (found freelancer)
  # from parsed search results contains `<keyword>` Log in stdout which freelancers and attributes contain `<keyword>`
  # and which do not.
  def any_attributes_contain(kwd)
    keyword = kwd.downcase
    $logger.info("Freelancer: checking freelancer attributes contain keyword '#{keyword}'")

    title_contains = @title.downcase.include?(keyword)
    description_contains = @description.downcase.include?(keyword)
    skills_contains = @skills.map {|skill| skill.downcase}.include?(keyword)
    matches = title_contains or description_contains or skills_contains

    $logger.info("Freelancer: Title contains '#{keyword}': #{!!title_contains}")
    $logger.info("Freelancer: Description contains '#{keyword}': #{!!description_contains}")
    $logger.info("Freelancer: Skills contains '#{keyword}': #{!!skills_contains}")

    $logger.info("Freelancer: Name: #{@name}")
    $logger.info("Freelancer: Title: #{@title}")
    $logger.info("Freelancer: Desc: #{@description}")
    $logger.info("Freelancer: Skills: #{@skills}")


    $logger.info("No matches!") if !matches
    $logger.info("\s")
    matches
  end
end
