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

get ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  erb(:city)
end

get ('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.update(params[:name])
  redirect to('/cities')
end

delete ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  redirect to('/cities')
end