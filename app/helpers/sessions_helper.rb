module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    if session[:user_id] && @current_user = User.find(session[:user_id])
      @current_user.update_last_seen
      return true
    else
      return false
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user_can?(permission)
    @current_user && @current_user.can?(permission)
  end

end
