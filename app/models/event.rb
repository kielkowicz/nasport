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
  before_save :prepare_event_end_time

  has_and_belongs_to_many :users
  belongs_to :place
  has_many :reports, :dependent => :destroy
 
  def owner
    User.find(owner_id)
  end

  def is_owner? user
    self.owner_id == user.id
  end

  def prepare_event_end_time
    self.end_time = self.event_day+self.duration.to_i.minutes # no need to check for existance or for numericality - validation is fired before these callback
  end
end
