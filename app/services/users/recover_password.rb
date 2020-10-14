class Users::RecoverPassword
  def initialize(user)
    @user = user
  end

  def call
    new_password = Devise.friendly_token.last(7)

    ::PasswordMailer.send_new_password(@user.id, new_password).deliver_now if @user.update(password: new_password)
  end

end
