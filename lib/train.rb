class Train
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each do |train|
      name = train.fetch('name')
      id = train.fetch('id')
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end
  
  def ==(train_to_compare)
    self.name() == train_to_compare.name()
  end

  def self.clear 
    DB.exec('DELETE FROM trains *;')
  end

  def self.find(id) 
    train = DB.exec("SELECT * FROM trains WHERE id=#{id};").first
    if train
      name = train.fetch('name') 
      id = train.fetch('id').to_i
      Train.new({name: name, id: id})
    else
      nil
    end
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:city_name)) && (attributes.fetch(:city_name) != nil)
      city_name = attributes.fetch(:city_name)
      time = attributes.fetch(:time)
      city = DB.exec("SELECT * FROM cities WHERE lower(name) = '#{city_name.downcase}';").first
      if city != nil
        DB.exec("INSERT INTO stops (city_id, train_id, time) VALUES (#{city['id'].to_i}, #{@id}, '#{time}');")
      end
    end
  end

  def delete
    DB.exec("DELETE FROM stops WHERE train_id = #{@id};")
    DB.exec("DELETE FROM trains WHERE id = #{self.id};")
  end

  def cities
    cities = []
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{@id};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("name")
      cities.push(City.new({:name => name, :id => city_id}))
    end
    cities
  end
end