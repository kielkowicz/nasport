# encoding: UTF-8
#
class EventsController < ApplicationController
  def new
    @event = current_user.events.build
    @places = Place.all #.map { |place| [place.id, place.name] }
  end
  
  def create 
    if Event.create! params[:event].merge({:owner_id=>current_user.id})
      flash[:notice] = 'Event was created!'
    else
      flash[:notice] = 'Even\'t wasn\'t created!'
    end
    
    redirect_to root_path
  end
  
  def edit
    begin
      @event = Event.find(params[:id])
      @places = Place.all
    rescue
      redirect_to root_path
    end
  end
  
  def update
    @event = Event.find(params[:id])

    if (@event.update_attributes(params[:event]))
        flash[:notice] = 'Event was updated!'
    else
        flash[:notice] = 'Event wasn\'t updated!'
    end

    redirect_to root_path
  end
  
  def show
    @event = Event.find(params[:id])
    @event_users = @event.users
  end
  
  def join
    event = Event.find(params[:id])
    @is_user_taking_part = event.users.include? current_user
    
    unless @is_user_taking_part
      if event.users << current_user then
        flash[:notice] = "Dołączyłeś do #{event.name}!"
      else
        flash[:notice] = "Nie dołączyłeś do #{event.name} z powodów technicznych!"
      end
    else
      flash[:notice] = "Już dołączyłeś do tego eventu!"
    end
    
    redirect_to root_path
  end
  
  def resign
    if Event.find(params[:id]).users.delete(current_user) 
      flash[:notice] = "Zostałeś wypisany z eventu!"
    else
      flash[:notice] = "Nie zstałeś wypisany z eventu!"
    end
    
    redirect_to root_path
  end
  
  def mine
    @mine_events={:owner => Event.where(['owner_id = ?', current_user.id]), :participant => current_user.events} 
  end
  
  def destroy
    begin
      if (Event.find(params[:id]).destroy) then
        flash[:notice] = 'Event został usunięty!'
      end
    rescue
      flash[:notice] = 'Był jakiś blłąd podczas usuwania => nic nie zostało usinięte.'
    end
    
    redirect_to reports_path
  end
end
