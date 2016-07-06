class PreferencesController < ApplicationController

  def index
    require_user
  end

  def update
    require_user

    if @current_user.update(preferences_params)
      flash[:success] = "Preferences successfully updated"
      redirect_to preferences_path
    else
      flash.now[:error] = @current_user.errors.full_messages.to_sentence
      render :index
    end

  end

  def update_password
    require_user

    # Confirm current password is correct before proceeding
    unless @current_user.authenticate(params[:current_password])
      flash[:error] = 'Incorrect password'
      return redirect_to preferences_path
    end

    # Coerce a blank password to an empty password to
    # force validation to fail
    password_params = password_reset_params
    if password_params[:password].blank?
      password_params[:password] = nil
    end

    # Attempt to update username and password
    if @current_user.update(password_params)
      flash[:success] = "Password successfully updated"
    else
      flash[:error] = @current_user.errors.full_messages.to_sentence
    end

    redirect_to preferences_path
  end

  private

  def preferences_params
    params.require(:user).permit(
      :name,
      :avatar_colour,
      :avatar_face,
      :email,
      :email_opted_in,
      :sms_opted_in,
      :twitter_opted_in,
      :sms_contact,
      :twitter_contact
    )
  end

  def password_reset_params
    params.permit(
      :password,
      :password_confirmation
    )
  end

end
