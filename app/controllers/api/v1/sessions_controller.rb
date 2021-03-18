class Api::V1::SessionsController < Api::ApiController
  def create
    response_handler(Users::SessionService.call(session_params: session_params))
  end

  def facebook_auth
    response_handler(Users::FacebookAuthService.call(fb_auth_params: fb_auth_params))
  end

  def apple_auth
    reponse_handler(Users::AppleService.call(apple_auth_params: apple_auth_params))
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def fb_auth_params
    params.permit(:access_token)
  end

  def reponse_handler(response)
    if response.success?
      sign_in response.result, store: false
      token = response.result.refresh_token
      respond_with response.result, location: '', scope: token
    else
      render_unprocessable_entity_error(response.error)
    end
  end

end
