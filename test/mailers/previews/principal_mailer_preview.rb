# Preview all emails at http://localhost:3000/rails/mailers/principal_mailer
class PrincipalMailerPreview < ActionMailer::Preview
def email_preview
    PrincipalMailer.email(Principal.first)
  end
end
