require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses")) 
  end  
    # responsible for using Nokogiri and open-uri to grab the entire HTML document from the web page.

  def get_courses
    self.get_page.css(".post")
  end 
    # responsible for using a CSS selector to grab all of the HTML elements that contain a course. 
    # In other words, the return value of this method should be a collection of Nokogiri XML elements

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end 
    # responsible for actually instantiating Course objects and giving each course object the correct title,
    # schedule and description attribute that we scraped from the page.
    # iterates over the collection of Nokogiri XML elements returned to us by the doc.css(".post") line, and
    # making a new instance of the Course class and giving that instance the title, schedule and description extracted.

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
    # It calls on .make_courses and then iterates over all of the courses that get created to puts out a 
    # list of course offerings. We gave you this freebie so that we can easily see how cool it is to 
    # scrape data and make real live Ruby objects with it.
end

Scraper.new.get_page 
Scraper.new.print_courses 