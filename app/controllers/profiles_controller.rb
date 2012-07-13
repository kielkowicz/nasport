class ProfilesController < ApplicationController
  def show
    begin
      @user = User.find params[:user_id]
    rescue
      flash[:notice] = 'User not found!'
      redirect_to root_path
    end
  end
end
