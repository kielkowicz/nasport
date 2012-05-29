# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  date       :date
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  place_id   :integer
#

class Event < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :place
  has_many :reports, :dependent => :destroy
  
  def owner
    User.find(owner_id)
  end
end
