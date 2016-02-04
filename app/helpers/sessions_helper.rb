module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    session[:user_id] && @current_user = User.find(session[:user_id])
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
