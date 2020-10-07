require('spec_helper')

describe('#City') do
  describe('.all') do
    it("returns an empty array when there are no citys") do
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an City") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      city2 = City.new({:name => "Seattle", :id => nil})
      city2.save()
      expect(City.all).to(eq([city, city2]))
    end
  end

  describe('.clear') do
    it("clears all Cities") do
      city = City.new({:name => "Atlanta", :id => nil})
      city.save()
      city2 = City.new({:name => "Louisville", :id => nil})
      city2.save()
      City.clear
      expect(City.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same City if it has the same attributes as another City") do
      city = City.new({:name => "Salem", :id => nil})
      city2 = City.new({:name => "Salem", :id => nil})
      expect(city).to(eq(city2))
    end
  end

  describe('.find') do
    it("finds a City by id") do
      city = City.new({:name => "Seaside", :id => nil})
      city.save()
      city2 = City.new({:name => "Cannon Beach", :id => nil})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#delete') do
    it("deletes a City by id") do
      city = City.new({:name => "Rockaway", :id => nil})
      city.save()
      city2 = City.new({:name => "Astoria", :id => nil})
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end

  describe('#update') do
    it("adds a train to an city") do
      city = City.new({:name => "Atlanta", :id => nil})
      city.save()
      train = Train.new({:name => "Thomas the Train", :id => nil})
      train.save()
      # train.update({:train_name => "Polar Express"})
      city.update({:train_name => "Thomas the Train"})
      expect(city.trains).to(eq([train]))
    end
  end
end