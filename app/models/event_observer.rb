class EventObserver < ActiveRecord::Observer
  
  def after_update event
    event.users.each do |user|
      # TODO: Use delay_job here!
      puts "Notifiying users about changes in events" 
      Notifier.event_changed(user,event).deliver
    end
  end
  
end
