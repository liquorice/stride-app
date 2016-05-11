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

    @user.update(access_level_id: params[:user][:access_level_id])
    flash[:success] = "Access level updated for #{@user.name}"
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
