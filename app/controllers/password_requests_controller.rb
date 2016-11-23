class PasswordRequestsController < ApplicationController
  layout 'modal'

  def send_password_reset
    # Attempt to find user(s) by name, or failing that by email address
    # Whilst usernames are enforced unique, emails are not,
    # so where is used rather than find, with results then iterated over
    users = @site.users.where(name: params[:user][:name])
    if users.empty?
      users = @site.users.where(email: params[:user][:name])
    end

    users.each do |user|
      unless user.email.blank?
        # Only send email to users with an email address,
        # but pretend it was sent regardless to not leak
        # information about accounts
        flash[:success] = "Meow, #{@host}"
        user.send_password_reset(@host)
      end
    end

    render :reset_sent
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
      flash[:success] = "Password reset successfully. Welcome back, #{user.name}"
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
