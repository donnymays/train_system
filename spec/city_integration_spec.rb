require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

before(:each) do
  City.clear()
end

describe('create an city path', {:type => :feature}) do
  it('creates a city and then goes back to the city page') do
    visit('/cities')
    click_on('Add a new City')
    fill_in('city_name', :with => 'Atlanta')
    click_on('Go!')
    expect(page).to have_content('Atlanta')
  end
end

describe('creates an individual city path', {:type => :feature}) do
  it('creates an individual city page') do
    visit('/cities')
    click_on('Add a new City')
    fill_in('city_name', :with => 'Atlanta')
    click_on('Go!')
    click_on('Atlanta')
    expect(page).to have_content('Return to City List')
  end
end

describe('creates a city edit path', {:type => :feature}) do
  it('creates a new view when edit city is clicked on') do
    visit('/cities')
    click_on('Add a new City')
    fill_in('city_name', :with => 'Atlanta')
    click_on('Go!')
    click_on('Atlanta')
    click_on('Edit City')
    fill_in('name', :with => 'Hotlanta')
    click_on('Update')
    expect(page).to have_content('Hotlanta')
  end
end