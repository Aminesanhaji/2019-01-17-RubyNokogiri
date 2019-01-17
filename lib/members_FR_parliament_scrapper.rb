#! usr/env/bin ruby
# frozen_string_literal: true

# require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_member_Parliament_name_email(index, directory_Nokogiri_page)
  name_xpath = '/html/body/div[1]/main/div/div/div[1]/ul[' + (index + 1).to_s + ']/li[1]/h2'
  email_xpath = '/html/body/div[1]/main/div/div/div[1]/ul[' + (index + 1).to_s + ']/li[5]/a[1]'

  _sex, first_name, *last_name = directory_Nokogiri_page.xpath(name_xpath).text.split(' ')
  email = directory_Nokogiri_page.xpath(email_xpath).text

  [first_name, last_name, email]
end

def get_members_Parliament_names_emails(directory_url_string)
  directory_page = Nokogiri::HTML(open(directory_url_string))

  members_parliament_directory_array = []

  577.times do |index|
    first_name, last_name, email = get_member_Parliament_name_email(index, directory_page)

    members_parliament_directory_array << set_hash(first_name, last_name, email)
  end

  members_parliament_directory_array
end

def set_hash(first_name, last_name, email)
  member_Parliament_hash = {}
  member_Parliament_hash[:first_name] = first_name
  member_Parliament_hash[:last_name] = last_name.join(' ')
  member_Parliament_hash[:email] = email
  member_Parliament_hash
end

def perform
  puts
  puts '=' * 60
  puts ' ' * 5 + 'LIST OF MEMBERS OF THE FRENCH PARLIAMENT'
  puts '=' * 60
  puts '    from https://www.voxpublic.org/'
  puts
  puts get_members_Parliament_names_emails('https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600')
  puts
  puts 'END'
end

perform
