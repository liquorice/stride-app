class PasswordRequestsController < ApplicationController
  layout 'modal'

  def send_password_reset
    if user = @site.users.find_by(name: params[:user][:name])
      unless user.email.blank?
        # Only send email to users with an email address,
        # but pretend it was sent regardless to not leak
        # information about accounts
        user.send_password_reset(@host)
      end
      render :reset_sent
    else
      render :no_user
    end
  end

  def reset
    @password_request = @site.password_requests.find_by(token: params[:token])
    require_existence @password_request
  end

  def do_reset
    @password_request = @site.password_requests.find_by(token: params[:token])
    require_existence @password_request

    user = @password_request.user

    if user.update(password_reset_params)
      # Remove all pending requests
      user.password_requests.destroy_all

      # Log user in
      log_in(user)
      flash[:success] = "Password reset succesfully. Welcome back, #{user.name}"
      redirect_to topics_preview_path
    else
      flash.now[:error] = user.errors.full_messages.to_sentence
      render :reset
    end

  end

  private

  def password_reset_params
    params.require(:user).permit(
      :password,
      :password_confirmation
    )
  end

end
