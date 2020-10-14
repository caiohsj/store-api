class Api::V1::UsersController < Api::ApiController
  before_action :authenticate_user_from_token!, except: [:create, :recovery_password]

  def create
    user = User.new(user_params)
    if user.save
      sign_in user, store: false
      respond_with user, location: '', scope: user.refresh_token
    else
      render_unprocessable_entity_error(user.errors.full_messages)
    end
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      render json: current_user, serializer: UserSerializer, scope: current_user.refresh_token
    else
      render_unprocessable_entity_error(current_user.errors.full_messages)
    end
  end

  def show
    headers = current_user.refresh_token
    respond_with current_user, location: '', scope: headers
  end

  def recovery_password
    recovery_service = ::Users::SendRecoveryPasswordService.call(email: recovery_password_params[:email])
    byebug
    response_handler(recovery_service)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def recovery_password_params
    params.permit(:email)
  end

  def response_handler(service)
    if service.success?
      render_success
    else
      render json: service.error, root: '', status: 422
    end
  end

end
