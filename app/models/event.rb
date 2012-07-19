# == Schema Information
#
# Table name: events
#
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
  
  attr_accessible :name, :event_day, :end_time, :description, :place_id, :owner_id, :max_users, :duration

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
    events = Event.where(['place_id=? and event_day>?', self.place_id, Time.now-1.day])
    
    events.each do |event_other|
      if (event_other.event_day..event_other.end_time+5.minute).overlaps?(self.event_day..self.event_day+self.duration.minute) then
      errors.add(:event_day, 'overlaps with other event!')
        break
      end
      
    end
  end
end

