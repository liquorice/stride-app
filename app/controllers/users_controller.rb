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
    success = verify_recaptcha(action: 'signup', minimum_score: 0.5, secret_key: ENV['RECAPTCHA_SECRET_KEY_V3'], model: @user)
    checkbox_success = verify_recaptcha(model: @user) unless success

    @user = @site.users.new(new_user_params)

    # Assign the default access group to the user
    # Default access level is the first record
    @user.access_level = @site.access_levels.first

    if (success || checkbox_success) && @user.save
      flash[:success] = "Account created, welcome #{@user.name}"
      log_in(@user)
      redirect_to topics_preview_path
    else
      @show_checkbox_recaptcha = true unless success
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

  def set_email
    require_permission :user_changeEmail

    @user = @site.users.find(params[:id])

    if @user.update(email: params[:user][:email])
      flash[:success] = "Email updated for #{@user.name}"
    else
      flash.now[:error] = @user.errors.full_messages.to_sentence
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

  def hide_activity
    require_permission :user_hideActivity
    @user = @site.users.find(params[:id])

    # Hide all public posts
    @user.posts.visible.update_all(visible: false, hidden_at: Time.now)

    # Hide all public threads
    @user.topic_threads.visible.update_all(public: false)

    flash[:success] = "All activity hidden for #{@user.name}"

    redirect_to user_path(@user)
  end

  def suspend
    require_permission :user_suspend
    @user = @site.users.find(params[:id])

    @user.update(suspended: true)
    flash[:success] = "#{@user.name} has been suspended"

    redirect_to user_path(@user)
  end

  def unsuspend
    require_permission :user_suspend
    @user = @site.users.find(params[:id])

    @user.update(suspended: false)
    flash[:success] = "#{@user.name} has been unsuspended"

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
