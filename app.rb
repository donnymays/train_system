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

get('/cities/:id') do
  @city = City.find(params[:id].to_i())
  erb(:city)
end

post('/cities/:id') do
  @train = Train.new({:name => params[:train_name], :id => nil})
  @train.save()
  @city = City.find(params[:id].to_i())
  @city.update(:train_name => params[:train_name])
  @city.trains
  #Display all trains that stop in this city
  erb(:city)
end

get('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.update(:name => params[:name])
  redirect to('/cities')
end

delete('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  redirect to('/cities')
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/trains/new') do
  erb(:new_train)
end

post('/trains') do
  name = params[:train_name]
  @train = Train.new({:name => name, :id => nil})
  @train.save()
  @trains = Train.all()
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

patch('/trains/:id') do
  @train = City.find(params[:id].to_i())
  @train.update(:name => params[:name])
  redirect to('/trains')
end

delete('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.delete()
  redirect to('/trains')
end

