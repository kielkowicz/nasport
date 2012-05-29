class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :place
  has_many :reports, :dependent => :destroy
  
  def owner
    User.find(owner_id)
  end
end
