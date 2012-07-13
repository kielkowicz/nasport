# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  place_id   :integer
#  owner_id   :integer
#  event_day  :datetime
#  duration   :integer
#  end_time   :datetime
#  id          :integer         not null, primary key
#  name        :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  place_id    :integer
#  owner_id    :integer
#  event_day   :datetime
#  duration    :integer
#  end_time    :datetime
#  max_users   :integer
#  description :text
#

class Event < ActiveRecord::Base
  validates :name, :presence => true 
  validate :is_place_free_for_event
  validates :max_users, :numericality => { :only_integer => true }
  validates :duration, :numericality => {:only_integer => true }

  has_and_belongs_to_many :users
  belongs_to :place
  has_many :reports, :dependent => :destroy
 
  before_save :prepare_event_end_time

  def owner
    User.find(owner_id)
  end

  def is_owner? user
    self.owner_id == user.id
  end
  
  def prepare_event_end_time
    self.end_time = self.event_day+self.duration.to_i.minutes # no need to check for existance or for numericality - validation is fired before these callback
  end

  def is_place_free_for_event
    events = Event.where(['place_id=? and end_time>?', self.place_id, self.event_day])
    events.each do |event_other|
      if event_other.end_time > self.event_day then
        errors.add(:event_day, 'Place has already been taken on that time!')
      end
      
    end
  end
end

