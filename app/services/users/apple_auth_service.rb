class Users::AppleAuthService < BusinessProcess::Base
  needs :apple_auth_params
  needs :device_params

  steps :fetch_public_key_apple,
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

  def fetch_public_key_apple
    apple_response = Net::HTTP.get(URI.parse("https://appleid.apple.com/auth/keys"))
    apple_certificate = JSON.parse(apple_response)

    key_apple = apple_certificate["keys"][0]
    keyHash = ActiveSupport::HashWithIndifferentAccess.new(key_apple)

    @public_key = (JWT::JWK.import(keyHash)).public_key
  end

  def token_decode
    private_key = apple_auth_params[:access_token]

    header_segment = JSON.parse(Base64.decode64(private_key.split(".").first))
    type_key = header_segment["alg"]

    begin
      @apple_user = JWT.decode(private_key, @public_key, true, {algorithm: type_key})[0]
    rescue StandardError => e
      fail(:apple_auth_error)
      Rails.logger.info("APPLE AUTH ERROR ======> #{e}")
    end
  end

  def find_apple_user
    @user = User.find_by(provider: 'apple', uid: @apple_user['sub'])
  end

  def find_user
    return if @user.present?

    @user = User.find_by(provider: 'email', email: @apple_user['email'])
  end

  def create_user
    return if @user.present?

    fail([I18n.t('services.session_service.errors.user_not_found')]) unless created_user_params?

    @user = User.new(provider: 'apple',
                     uid: @apple_user['id'],
                     email: @apple_user['email'],
                     name: apple_auth_params[:name],
                     password: Devise.friendly_token[0, 20])

    fail(@user.errors.full_messages) if @user.errors.present?
  end

  def created_user_params
    apple_auth_params.include?(:name, :email)
  end

end
