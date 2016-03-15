class SessionsController < ApplicationController

  def new
    return redirect_to :root if logged_in?

    render :login, layout: 'modal'
  end

  def create
    user = @site.users.find_by(name: params[:session][:name])
    return failed unless user

    if user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to :root
    else
      failed
    end
  end

  def destroy
    log_out
    redirect_to :root
  end

  private

  def failed
    flash.now[:error] = 'Invalid name/password combination' # Not quite right!
    render :login, layout: 'modal'
  end

end
