# encoding: UTF-8
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  
  protect_from_forgery
  
  protected
  def only_for_admins
    unless current_user.admin?
      flash[:notice] = 'Nie masz uprawnien do tej akcji'
      redirect_to root_path
    end
  end
end
