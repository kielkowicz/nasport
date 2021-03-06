# encoding: UTF-8
#
class EventsController < ApplicationController
  def new
    @event = current_user.events.build
    #@places = Place.all #.map { |place| [place.id, place.name] }
    @cities = City.all
    @places = @cities.first.places
    @disciplines = Discipline.all
  end
  
  def create 
    @event = Event.new params[:event].merge({:owner_id=>current_user.id})
 
    if @event.save     
      flash[:notice] = 'Event was created!'
      redirect_to root_path
    else
      #@places = Place.all
      @cities = City.all
      @places = @cities.first.places
      @disciplines = Discipline.all
      flash[:notice] = 'Even\'t wasn\'t created!'
      render :action => :new
    end
  end
  
  def edit
    #begin
      @event = Event.find(params[:id])
      #@places = Place.all
      @cities = City.all
      #@places = @cities.first.places
      @places = @event.place.city.places
      @disciplines = Discipline.all
   # rescue
   #   redirect_to root_path
   # end
    
  end
  
  def update
    @event = Event.find(params[:id])

    if (@event.update_attributes(params[:event]))
        flash[:notice] = 'Event was updated!'
        redirect_to root_path
    else
        flash[:notice] = 'Event wasn\'t updated!'
        #@places = Place.all
        @cities = City.all
        @places = @event.place.city.places
        @disciplines =Discipline.all
        render :action => :edit
    end
  end
  
  def show
    begin
      @event = Event.find(params[:id])
      @event_users = @event.users
      
      @place = @event.place

      geocode = Geocoder.search("#{@place.address}, #{@place.city.name}")
      
      @place_geometry = { :lng => geocode[0].data["geometry"]["location"]["lng"], :lat => geocode[0].data["geometry"]["location"]["lat"] }
    
    rescue
      flash[:notice] = 'No event found!'
      redirect_to root_path    
    end
  end
  
  def join
    event = Event.find(params[:id])
    @is_user_taking_part = event.users.include? current_user
    
    unless @is_user_taking_part
      if event.max_users == event.users.count then
        flash[:notice] = 'Już nie ma miejsc wolnych na ten event'
      else
        if event.users << current_user then
          flash[:notice] = "Dołączyłeś do #{event.name}!"
        else
          flash[:notice] = "Nie dołączyłeś do #{event.name} z powodów technicznych!"
        end
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
    
    
    path = reports_path
    
    unless request.referer =~ /events/  
      path = reports_path
    else
      path = root_path
    end

    redirect_to path
  end
  
  def search
    @cities = City.all
    @disciplines = Discipline.all

    if request.xhr?
      @city =City.find(params[:city][:id])
      
      @places_id = @city.places.map(&:id)


      @events = Event.where('place_id in (?) and discipline_id=? and archive = ? ', @places_id, params[:discipline][:id], false)
      render 'ajax_table', :layout => false
    else
    
    end

  end
end
