#! usr/env/bin ruby
# frozen_string_literal: true

# require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def crypto_currencies_hash_scrapper(
  page_url_string,
  name_xpath_string,
  price_xpath_string,
  print_trigger = false
)

  page = Nokogiri::HTML(
    open(page_url_string)
  )

  currencies_names = page.css(name_xpath_string)

  currencies_prices = page.css(price_xpath_string)

  currencies_names_prices_hash = {}

  if print_trigger
    puts '=' * 60
    puts ' ' * 5 + 'CURRENCIES'
    puts '=' * 60
    puts
  end

  # binding.pry
  currencies_names.zip(currencies_prices).each do |currency_name, currency_price|
    if print_trigger
      puts '-' * 60
      puts
      puts "currency name: #{currency_name.text}"
      puts "currency price: USD #{currency_price['data-usd'].to_f}"
      puts
    end
    currencies_names_prices_hash[currency_name.text.to_s.to_sym] =
      currency_price['data-usd'].to_f
  end
  currencies_names_prices_hash
end

def perform
  page_url_string = 'https://coinmarketcap.com/all/views/all/'
  name_xpath_string = '//span[@class="currency-symbol visible-xs"]/a'
  price_xpath_string = '//a[@class="price"][data-usd]'
  crypto_currencies_hash = crypto_currencies_hash_scrapper(
    page_url_string, name_xpath_string, price_xpath_string
  )
end

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
