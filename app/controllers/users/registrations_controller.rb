class Users::RegistrationsController < Devise::RegistrationsController
  include Devise::Controllers::Helpers
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    if resource.token.include?("mnps")
      resource.role = 4
    elsif resource.token.include?("volunteer")
      resource.role = 0
    elsif resource.token.include?("hotline teacher")
      resource.role = 1
    elsif resource.token.include?("5h43bf3ff2azce43")
      resource.role = 5
      resource.district = "null"
    elsif resource.token.include?("ghr4 th43 greh 4u5j rbre 3tgr j3nr 97md")
      resource.role = 6
      resource.district = "null"
    elsif resource.token.include?("math teacher")
      resource.role = 2
    elsif resource.token.include?("reading teacher")
      resource.role = 3
    end
    resource.save!
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  # GET /resource/edit
   #def edit
   #end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
   def destroy
     super
     ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
    protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
