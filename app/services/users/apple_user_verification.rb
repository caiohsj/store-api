class Users::AppleUserVerification < BusinessProcess::Base
    needs :apple_auth_params
    needs :apple_user_data
  
    steps :find_apple_user,
          :find_user,
          :created_user_params,
          :create_user
  
    def call
      process_steps
      @user
    end
  
    private
  
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
                          name: apple_auth_params[:name],
                          password: Devise.friendly_token[0, 20])
  
      fail(@user.errors.full_messages) if @user.errors.present?
    end
  
    def define_email
      apple_auth_params[:email].present? ? apple_auth_params[:email] : apple_user_data['email'].to_s
    end
  
  end
  