class PreferencesController < ApplicationController

  def index
    require_permission :preferences_modify
  end

  def update
    require_permission :preferences_modify

    if @current_user.update(preferences_params)
      flash[:success] = "Preferences succesfully updated"
      redirect_to preferences_path
    else
      flash.now[:error] = @current_user.errors.full_messages.to_sentence
      render :index
    end

  end

  def update_password
    require_permission :preferences_modify

    # Confirm current password is correct before proceeding
    unless @current_user.authenticate(params[:current_password])
      flash[:error] = 'Incorrect password'
      return redirect_to preferences_path
    end

    # raise password_params.inspect

    # Attempt to update username and password
    if @current_user.update(password_params)
      flash[:success] = "Password succesfully updated"
    else
      flash[:error] = @current_user.errors.full_messages.to_sentence
    end

    redirect_to preferences_path
  end

  private

  def preferences_params
    params.permit(:name, :avatar_colour, :avatar_face)
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end

end