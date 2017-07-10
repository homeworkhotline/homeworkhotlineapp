class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :time_diff
  helper_method :round_time
  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def round_time(t)
  rounded = Time.at((t.to_time.to_i / 900.0).round * 900)
  t.is_a?(DateTime) ? rounded.to_datetime : rounded
end

    def time_diff(start_time, end_time)
  seconds_diff = ((start_time - end_time).to_d.abs / 3600)
	"#{seconds_diff}"
	end

  def after_sign_in_path_for(resource)
    new_time_clock_path
  end

  protected
  	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation, :firstname, :lastname, :token])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :firstname, :men, :district, :school])
	end

end
