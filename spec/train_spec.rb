require 'spec_helper'

describe '#Train' do

  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves a Train") do
      train = Train.new({:name => "Thomas the Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Polar Express", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end

  describe('.clear') do
    it("clears all Trains") do
      train = Train.new({:name => "Thomas the Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Polar Express", :id => nil})
      train2.save()
      Train.clear
      expect(Train.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same Train if it has the same attributes as another Train") do
      train = Train.new({:name => "Polar Express", :id => nil})
      train2 = Train.new({:name => "Polar Express", :id => nil})
      expect(train).to(eq(train2))
    end
  end

  describe('.find') do
    it("finds a Train by id") do
      train = Train.new({:name => "Thomas the Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Polar Express", :id => nil})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end

  describe('#delete') do
    it("deletes a Train by id") do
      train = Train.new({:name => "Thomas the Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Polar Express", :id => nil})
      train2.save()
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('#update') do
    it("adds a city to an train") do
      train = Train.new({:name => "Thomas the Train", :id => nil})
      train.save()
      city = City.new({:name => "A Love Supreme", :id => nil})
      city.save()
      train.update({:city_name => "A Love Supreme"})
      expect(train.cities).to(eq([city]))
    end
  end
end