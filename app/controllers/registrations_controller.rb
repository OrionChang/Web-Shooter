class RegistrationsController < Devise::RegistrationsController
	

	before_filter :configure_permitted_parameters, if: :devise_controller?

	def create
		build_resource(sign_up_params)

		if resource.save
			if resource.active_for_authentication?
				set_flash_message :notice, :signed_up if is_navigational_format?
				sign_up(resource_name, resource)
				respond_with resource, :location => after_sign_up_path_for(resource)
			else
				set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
				expire_session_data_after_sign_in!
				respond_with resource, :location => after_inactive_sign_up_path_for(resource)
			end


		else
			clean_up_passwords resource
			respond_with resource
		end

		session[:omniauth] = nil unless self.resource.new_record?
	end

	def edit



    	if !resource.profile

			resource.build_profile
			
		end

		render :edit
  end



  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.


  protected

  def after_sign_up_path_for(resource)
      edit_user_registration_path(resource)
  end



  def build_resource(*args)
  	super
  	if session[:omniauth]
  		self.resource.apply_omniauth(session[:omniauth])
  	end
  end


  def configure_permitted_parameters



  	devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password, profile_attributes:[:id, :nickname, :photo])}


  end




end