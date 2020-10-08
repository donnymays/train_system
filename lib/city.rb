require 'pry'

class City
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(other_city)
    self.name() == other_city.name()
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def save()
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def self.clear 
    DB.exec('DELETE FROM cities *;')
  end

  def self.find(id) 
    city = DB.exec("SELECT * FROM cities WHERE id=#{id};").first
    if city
      name = city.fetch('name') 
      id = city.fetch('id').to_i
      City.new({name: name, id: id})
    else
      nil
    end
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:train_name)) && (attributes.fetch(:train_name) != nil)
      train_name = attributes.fetch(:train_name)
      time = attributes.fetch(:time)
      train = DB.exec("SELECT * FROM trains WHERE lower(name)='#{train_name.downcase}';").first
      if train != nil
        DB.exec("INSERT INTO stops (train_id, city_id, time) VALUES (#{train['id'].to_i}, #{@id}, '#{time}');")
      end
    end
  end

  def delete
    DB.exec("DELETE FROM stops WHERE city_id = #{@id};")
    DB.exec("DELETE FROM cities WHERE id = #{self.id};")
  end

  def trains
    trains = []
    results = DB.exec("SELECT train_id, time FROM stops WHERE city_id = #{@id};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      time = result.fetch("time")
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      array = []
      array.push(Train.new({:name => name, :id => train_id}))
      array.push(time)
      trains.push(array)
    end
    trains
  end
end

# trains[0].name -> name trains[1] -> time