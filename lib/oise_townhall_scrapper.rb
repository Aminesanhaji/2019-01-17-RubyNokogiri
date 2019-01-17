#! usr/env/bin ruby
# frozen_string_literal: true

# require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_townhall_name_email(town_url_string)
  townhall_url_xpath_string = '/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]'

  townhall_name_xpath_string = '//a[@class="lientxt4"]'

  page = Nokogiri::HTML(open(town_url_string))

  town_url = page.css(townhall_url_xpath_string)

  town_name_county = page.css(townhall_name_xpath_string)

  [town_name_county[0].text, town_url.text]
end

def get_townhall_urls(val_doise_url_string)
  val_doise_towns_url_array = []

  url_prefix_string = 'http://annuaire-des-mairies.com/'

  page = Nokogiri::HTML(open(val_doise_url_string))

  townhall_names_xpath_string = '//a[@class="lientxt"]'

  towns_urls = page.css(townhall_names_xpath_string)

  towns_urls.each do |town_url|
    val_doise_towns_url_array <<
      url_prefix_string + town_url['href'].to_s[2..-1]
  end

  val_doise_towns_url_array
end

def perform
  val_doise_url_string = 'http://annuaire-des-mairies.com/val-d-oise.html'

  val_doise_towns_url_array = get_townhall_urls(val_doise_url_string)

  name_email_townhall_hash = {}

  val_doise_towns_url_array.each do |town_url|
    town_name_string, town_email_string = get_townhall_name_email(town_url)
    name_email_townhall_hash[town_name_string.to_sym] = town_email_string
  end
  name_email_townhall_hash
end

# def perform
#   # page_url_string = "http://annuaire-des-mairies.com/95/avernes.html"
#   # town_name, town_email = get_townhall_name_email(
#   #   page_url_string, true)

#   val_doise_url_string = "http://annuaire-des-mairies.com/val-d-oise.html"

#   val_doise_towns_url_array = get_townhall_urls(val_doise_url_string)

#   puts val_doise_towns_url_array
# end

perform

# <a href="/currencies/bumbacoin/#markets" class="price" data-usd="0.000472505792595" data-btc="1.2999149487e-07">$0,000473</a>
# news_link = page.css('div#references a')
# news_link.each do |link|
#   puts "text: #{link.text} and URL: #{link["href"]}"
# end

# puts "=" * 60

# page = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/HTML"))
# puts page.class   # => Nokogiri::HTML::Document

# puts "TITLE"
# puts page.css("title")[0].name   # => title
# puts page.css("title")[0].text   # => My webpage
# puts
# puts

# news_link = page.css('div#references a')

# //*[@id="id-bitcoin"]
# //*a[@class="currency-name-container"].text

# def words_counter(corpus_string, dict_array)
#   words = corpus_string.downcase.split(/\W+/)

#   words_count_hash = Hash.new do |hash, word_key|
#     hash[word_key] = words.count(word_key)
#   end

#   dict_array.each do |searched_word|
#     words_count_hash[searched_word]
#     words_count_hash.keep_if { |_word_key, count_value| !count_value.zero? }
#   end

#   puts words_count_hash

#   words_count_hash
# end
