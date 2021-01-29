# Preview all emails at http://localhost:3000/rails/mailers/password_mailer
class PasswordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/password_mailer/send_new_password_mailer
  def send_new_password_mailer
    PasswordMailer.send_new_password_mailer
  end

end
