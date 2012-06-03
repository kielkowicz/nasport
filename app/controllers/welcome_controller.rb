# encoding: UTF-8
class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  
  def index                                        
      @events = Event.order('updated_at desc').limit(5)
      
  end
end
