require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('./lib/city')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "train_system"})

get('/') do
  @cities = City.all
  erb(:cities)
end

get('/cities') do
  @cities = City.all
  erb(:cities)
end

get('/cities/new') do
  erb(:new_city)
end

post('/cities') do
  name = params[:city_name]
  city = City.new({:name => name, :id => nil})
  city.save()
  @cities = City.all()
  erb(:cities)
end