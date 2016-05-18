class UsersController < ApplicationController

  def index
    require_permission :users_view

    @access_levels = @site.access_levels
  end

  def show
    require_permission :users_view

    @user = @site.users.find(params[:id])
  end

  def register
    render :register, layout: 'modal'
  end

  def signup
    @user = @site.users.new(new_user_params)

    # Assign the 0th access group to the user
    @user.access_level = @site.access_levels.first

    if @user.save
      flash[:success] = "Account created, welcome #{@user.name}"
      log_in(@user)
      redirect_to topics_preview_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :register, layout: 'modal'
    end
  end

  def set_access_level
    require_permission :accessLevel_set
    @user = @site.users.find(params[:id])

    new_access_level = @site.access_levels.find(params[:user][:access_level_id])
    if @current_user.can_set_access_level?(new_access_level)
      @user.update(access_level_id: new_access_level.id)
      flash[:success] = "Access level updated for #{@user.name}"
    else
      flash[:error] = "Unable to update access level for #{@user.name}"
    end

    redirect_to user_path(@user)
  end

  def send_password_reset
    require_permission :users_view
    @user = @site.users.find(params[:id])

    unless @user.email.blank?
      @user.send_password_reset(@host)
      flash[:success] = "Password reset email sent to #{@user.name}"
    else
      flash[:error] = "#{@user.name} does not have a saved email address"
    end

    redirect_to user_path(@user)
  end

  private

  def new_user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
