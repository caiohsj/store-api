class ::Users::FacebookAuthService < BusinessProcess::Base
  needs :fb_auth_params
  needs :device_params

  steps :fetch_facebook,
        :find_facebook_user,
        :find_user,
        :create_user

  def call
    process_steps
    @user
  end

  private

  def fetch_facebook
    graph = Koala::Facebook::API.new(fb_auth_params[:access_token])
    begin
      @facebook_user = graph.get_object('me', fields: [:name, :email])
    rescue Exception
      fail(:facebook_auth_error)
    rescue Exception
      fail(:unknow_error)
    end
  end

  def find_facebook_user
    @user = User.find_by(provider: 'facebook', uid: @facebook_user['id'])
  end

  def find_user
    return if @user.present?

    @user = User.find_by(provider: 'email', email: @facebook_user['email'])
  end

  def create_user
    return if @user.present?

    avatar_url = "https://graph.facebook.com/#{@facebook_user['id']}/picture"
    @user = User.new(provider: 'facebook', uid: @facebook_user['id'],
                     email: define_email(@facebook_user), name: @facebook_user['name'],
                     password: Devise.friendly_token[0, 20], remote_avatar_url: avatar_url,
                     synced_fb: false)
    fail([I18n.t('facebok_auth.email_exists')]) if User.exists?(email: @facebook_user['email'])
  end

  def define_email(fb_user)
    # When user does't has email in your fb account
    # TODO: Mudar o email base aqui!!!!
    fb_user['email'].present? ? fb_user['email'] : "#{fb_user['uid']}@jera.com.br"
  end

end
