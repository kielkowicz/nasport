class NotifiersController < ApplicationController
  respond_to :json 
  skip_before_filter :authenticate_user!
  http_basic_authenticate_with :name => 'prog', :password => 'prog_access'

  def mark_archive_events
    begin
      @events = Event.where('event_day < ? and archive =?', Time.now-1.hour, false)  

      #TODO: insufficent when there is a lot records in database.
      i=0
      @events.each do |event|
        i=i+1
        event.update_column :archive, true
      end
    
      @status="ok"
      @updated = i
    rescue
      @status="error"
    end

    
    respond_to do |format|
      format.json { render :layout => false}
    end
  end

  #TODO: shity implementation!  
  def send_reminder
    @events_found = Array.new
    @events_users = Array.new
    @events = Event.where('archive = ? and reminded = ?', false, false)
    @events.each do |event|
      if event.within? 1.day
        
        @events_found.append event
       
        event.users.each do |user|
          #TODO: use delay_job here!
           @events_users.append user.email
           Notifier.event_in_one_day(user, event).deliver
        end
        event.update_column :reminded, true
      end
    end

    render :layout => false 
  end
end
