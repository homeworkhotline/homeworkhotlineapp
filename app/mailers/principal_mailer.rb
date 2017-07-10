class PrincipalMailer < ApplicationMailer

def email(principal)
	@principal = principal
	 mail(to: "homeworkhotlinenashville@gmail.com", subject: "#{@principal.schoolsystem} has filled out their contract.")
end

end