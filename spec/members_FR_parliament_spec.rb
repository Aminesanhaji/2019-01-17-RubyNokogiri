# frozen_string_literal: true

require_relative '../lib/members_FR_parliament_scrapper'

directory_url_string = 'https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600'
directory_Nokogiri_page = Nokogiri::HTML(open(directory_url_string))
first_name = 'Thibaut'
last_name = %w[de Miquel]
email = 'a@a.com'

describe 'get_member_Parliament_name_email' do
  it 'returns an Array' do
    expect(get_member_Parliament_name_email(3, directory_Nokogiri_page))
      .to be_instance_of(Array)
  end

  it 'returns the name of the Member of Parliament and his email' do
    expect(get_member_Parliament_name_email(3, directory_Nokogiri_page)[0])
      .to be_instance_of(String)
    expect(get_member_Parliament_name_email(3, directory_Nokogiri_page)[1])
      .to be_instance_of(Array)
    expect(get_member_Parliament_name_email(3, directory_Nokogiri_page)[2])
      .to include('@')
  end
end

describe 'get_members_Parliament_names_emails' do
  it 'returns an Array' do
    expect(get_members_Parliament_names_emails(directory_url_string))
      .to be_instance_of(Array)
  end

  it 'has Hashes as Elements' do
    expect(get_members_Parliament_names_emails(directory_url_string)[3])
      .to be_instance_of(Hash)
  end

  it 'has Hashes as Elements with :first_name as key' do
    expect(get_members_Parliament_names_emails(directory_url_string)[3][:first_name])
      .to be_instance_of(String)
  end
end

describe 'set_hash' do
  it 'returns a Hash' do
    expect(set_hash(first_name, last_name, email))
      .to be_instance_of(Hash)
  end
end
