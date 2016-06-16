class SessionsController < ApplicationController

  def new
    return redirect_to topics_preview_path if logged_in?

    render :login, layout: 'modal'
  end

  def create
    user = @site.users.find_by(name: params[:session][:name])
    return failed unless user

    if user.authenticate(params[:session][:password])
      log_in(user, params[:session][:remember])
      flash[:success] = "Welcome back, #{user.name}"
      redirect_to topics_preview_path
    else
      failed
    end
  end

  def destroy
    log_out
    redirect_to topics_preview_path
  end

  private

  def failed
    flash.now[:error] = 'Invalid name/password combination' # Not quite right!
    render :login, layout: 'modal'
  end

end
