class Users::AppleAuthService < BusinessProcess::Base
  needs :apple_auth_params
  needs :device_params

  steps :initialize_client,
        :fetch_public_key_apple,
        :token_decode,
        :auth_apple_user,
        :find_apple_user,
        :find_user,
        :create_user

  def call
    process_steps
    @user
  end

  private

  def initialize_client
    @client = ::Clients::AppleAuthClient.new
  end

  def fetch_public_key_apple
    apple_response = @client.public_key_apple

    key_apple = apple_response.result[:keys].first

    key_hash = ActiveSupport::HashWithIndifferentAccess.new(key_apple)

    @public_key = JWT::JWK.import(key_hash).public_key
  end

  def token_decode
    @private_key = apple_auth_params[:apple_token]

    header_segment = JSON.parse(Base64.decode64(@private_key.split('.').first))
    @type_key = header_segment['alg']
  end

  def auth_apple_user
    @apple_user = JWT.decode(@private_key, @public_key, true, { algorithm: @type_key }).first
  rescue StandardError
    fail(:apple_auth_error)
  end

  def find_apple_user
    @user = User.find_by(provider: 'apple', uid: apple_auth_params['user_id'])
  end

  def find_user
    return if @user.present?

    @user = User.find_by(provider: 'email', email: apple_auth_params['email'])
  end

  def created_user_params
    apple_auth_params.include?(:name) && apple_auth_params.include?(:email)
  end

  def create_user
    return if @user.present?

    fail([I18n.t('services.session_service.errors.user_not_found')]) unless created_user_params

    @user = User.create(provider: 'apple',
                        uid: apple_auth_params['user_id'],
                        email: define_email,
                        name: define_name,
                        password: Devise.friendly_token[0, 20])

    fail(@user.errors.full_messages) if @user.errors.present?
  end

  def define_email
    apple_auth_params[:email].present? ? apple_auth_params[:email] : "#{@apple_user['email']}"
  end

  def define_name
    apple_auth_params[:name].present? ? apple_auth_params[:name] : "#{apple_auth_params[:user_id]}"
  end

end
