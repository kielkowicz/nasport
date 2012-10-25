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
  validates :name, :presence => true, :length => { :minimum=>5 }
  validates :max_users, :numericality => { :only_integer => true, :less_then => 22 }
  validates :duration, :numericality => {:only_integer => true, :greater_than_or_equal_to => 30, :less_than => 180}
  validates :event_day, :presence => true 
  
  #custom validators
  validate :is_place_free_for_event, :if => :should_validate_events_availability?
  validate :date_within_reason
  
  #relations
  has_and_belongs_to_many :users
  belongs_to :place
  has_many :reports, :dependent => :destroy
  belongs_to :discipline

  #collbacs
  before_save :prepare_event_end_time
  
  attr_accessible :name, :event_day, :end_time, :description, :place_id, :owner_id, :max_users, :duration, :discipline_id

  def should_validate_events_availability?
    place.closed
  end

  def owner
    User.find(owner_id)
  end

  def is_owner? user
    self.owner_id == user.id
  end
  
  def prepare_event_end_time
    self.end_time = self.event_day+self.duration.to_i.minutes # no need to check for existance or for numericality - validation is fired before these callback
  end
  
  protected
  def date_within_reason
    unless event_day.nil?
    errors[:event_day] = "Event day must be within #{EVENT_DAY_MUST_BE_IN_MAX_DAYS} days  from today" unless event_day.between?(
      Time.now, Time.now+EVENT_DAY_MUST_BE_IN_MAX_DAYS.day)
    else
      errors[:event_day] = 'Must be presence!'
    end
  end

  def is_place_free_for_event
    events = Event.where(['place_id=? and event_day>?', self.place_id, Time.now-1.day])
    
    events.each do |event_other|
      if self.new_record?
        if (event_other.event_day..event_other.end_time+5.minute).overlaps?(self.event_day..self.event_day+self.duration.minute) then
        errors.add(:event_day, 'overlaps with other event!')
          break
        end
      else
        if (self.id != event_other.id) and (event_other.event_day..event_other.end_time+5.minute).overlaps?(self.event_day..self.event_day+self.duration.minute) then
        errors.add(:event_day, 'overlaps with other event!')
          break
        end
      end
    end
  end
 
  public 
  #eg. event.within? 1.day
  def within? time
    self.event_day.year == Time.now.year && self.event_day.month == Time.now.month && ( (self.event_day-time).day==Time.now.day )
  end
  
  def has_free_spot?
    users.count < max_users
  end
end

