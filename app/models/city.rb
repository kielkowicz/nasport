class City < ActiveRecord::Base
  validates :name, :uniqueness=>true
  geocoded_by :name, :latitude => :lat, :longitude => :lon

  has_many :places, :dependent=>:destroy

  after_validation :geocode
end
