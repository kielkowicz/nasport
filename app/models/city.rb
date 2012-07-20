class City < ActiveRecord::Base
  validates :name, :uniqueness=>true

  has_many :places, :dependent=>:destroy
end
