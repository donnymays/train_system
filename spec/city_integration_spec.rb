require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('create an city path', {:type => :feature}) do
  it('creates an city and then goes back to the city page') do
    visit('/cities')
    click_on('Add a new City')
    fill_in('city_name', :with => 'Atlanta')
    click_on('Go!')
    expect(page).to have_content('Atlanta')
  end
end