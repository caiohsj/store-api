class Users::AppleAuthService < BusinessProcess::Base
  needs :apple_auth_params
  needs :device_params

  steps :initialize_client,
        :fetch_public_key_apple,
        :token_decode,
        :find_public_key,
        :auth_apple_user,
        :verify_user

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

    @apple_certificate = apple_response.result[:keys]
  end

  def token_decode
    header_segment = JSON.parse(Base64.decode64(apple_auth_params[:apple_token].split('.').first))

    @kid = header_segment['kid']
    @alg = header_segment['alg']
  end

  def select_key
    @apple_certificate.select { |key| key[:kid] == @kid }[0]
  end

  def find_public_key
    hash_key = ActiveSupport::HashWithIndifferentAccess.new(select_key)
    @public_key = JWT::JWK.import(hash_key)
  end

  def auth_apple_user
    @apple_user_data = JWT.decode(apple_auth_params[:apple_token], @public_key.public_key, true, algorithm: @alg)[0]
  rescue StandardError => e
    fail(:apple_auth_error)
    Rails.logger.info("APPLE AUTH ERROR ======> #{e}")
  end

  def verify_user
    verification = Users::AppleUserVerification.call(apple_auth_params: apple_auth_params,
                                                     apple_user_data: @apple_user_data)
    fail unless verification.success?

    @user = verification.result
  end

  def define_email
    apple_auth_params[:email].present? ? apple_auth_params[:email] : @apple_user['email'].to_s
  end

  def define_name
    apple_auth_params[:name].present? ? apple_auth_params[:name] : apple_auth_params[:user_id].to_s
  end

end
