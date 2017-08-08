class LocMailer < ApplicationMailer
	def send_loc_notice(user)
	@user = user
	 mail(to: @user.email , subject: "INFO FOR PAYROLL! URGENT!!!!!!!")
	end
end
