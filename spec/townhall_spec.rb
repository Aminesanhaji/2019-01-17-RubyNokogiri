# frozen_string_literal: true

require_relative '../lib/oise_townhall_scrapper'

val_doise_url_string = "http://annuaire-des-mairies.com/val-d-oise.html"
town_url_string  = "http://annuaire-des-mairies.com/95/avernes.html"


describe 'get_townhall_name_email' do
  
  it 'returns an Array' do
    expect(get_townhall_name_email(town_url_string)).
      to be_instance_of(Array)
  end

  it 'returns the name of the town and a url (Test on Avernes)' do
    expect(get_townhall_name_email(town_url_string)[0].downcase).
    to eq('avernes')
    expect(get_townhall_name_email(town_url_string)[1]).
    to include('@')
	end
end


describe 'get_townhall_urls' do
  
  it 'returns an Array' do
    expect(get_townhall_urls(val_doise_url_string)).
      to be_instance_of(Array)
  end

  it 'returns http email addresses' do
    expect(get_townhall_urls(val_doise_url_string)[1]).
    to include('http://')
  end
end

describe 'perform' do
  it 'returns a Hash' do
        expect(perform).to be_instance_of(Hash)
      end
  it 'returns a Hash with emails as values' do
    expect(perform.to_a.sample(1).to_h.values.to_s).
    to include('@')
  end
end







