class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception






  def authenticate_user_profile!
  	if !current_user.profile || !current_user.profile.nickname

  		redirect_to edit_user_registration_path(current_user), :alert => "Please update your profile (at least your nickname) before next step."

  		
  	end
  end



  protected

  
end
