# frozen_string_literal: true

require_relative '../lib/crypto_currencies_scrapper'

page_url_string = "https://coinmarketcap.com/all/views/all/"
name_xpath_string = '//span[@class="currency-symbol visible-xs"]/a'
price_xpath_string = '//a[@class="price"][data-usd]'

describe 'crypto_currencies_hash_scrapper' do
  
  it 'returns a hash' do
    expect(crypto_currencies_hash_scrapper(
		page_url_string, name_xpath_string, price_xpath_string)).
    to be_instance_of(Hash)
  end

  it 'includes Bitcoin and Ethereum, with a price each time' do
    expect(crypto_currencies_hash_scrapper(
		page_url_string, name_xpath_string, price_xpath_string)[:BTC]).
    to be_instance_of(Float)
    expect(crypto_currencies_hash_scrapper(
		page_url_string, name_xpath_string, price_xpath_string)[:ETH]).
    to be_instance_of(Float)
	end
end


