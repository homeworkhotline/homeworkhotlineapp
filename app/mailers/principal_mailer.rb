class PrincipalMailer < ApplicationMailer


def email(principal)
	@principal = principal
	 mail(to: "volunteer@homeworkhotline.info", subject: "#{@principal.schoolsystem.capitalize} has filled out their contract.")
end
end

