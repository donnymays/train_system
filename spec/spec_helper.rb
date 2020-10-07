require 'rspec'
require 'pg'
require 'city'
require 'train'
require 'pry'

DB = PG.connect({:dbname => 'train_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM trains *;')
    DB.exec('DELETE FROM cities *;')
  end
end