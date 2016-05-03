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

    if @user.save
      flash[:success] = "Account created, welcome #{@user.name}"
      log_in(@user)
      redirect_to topics_preview_path
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
      render :register, layout: 'modal'
    end

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
