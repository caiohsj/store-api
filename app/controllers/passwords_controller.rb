class PasswordsController < Devise::PasswordsController
  def edit
  end

  def update
    self.resource = resource_class.reset_password_by_token(update_params)

    if resource.errors.messages.empty?
      flash[:notice] = t('admin.js.validations.password.success')
    else
      flash[:alert] = resource.errors.full_messages.first.to_s
    end
    redirect_to action: 'edit', reset_password_token: params[:reset_password_token]
  end

  def update_params
    params.permit(:token, :reset_password_token, :password, :password_confirmation)
  end

end
