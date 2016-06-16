module SessionsHelper

  def log_in(user, remember = false)
    ensure_not_suspended(user)

    cookies.signed[:user_id] = {
      value: user.id,
      expires: (remember ? 1.month.from_now : nil)
    }
  end

  def logged_in?
    if cookies.signed[:user_id] && @current_user = User.find_by(id: cookies.signed[:user_id])
      ensure_not_suspended(@current_user)
      @current_user.update_last_seen
      return true
    else
      return false
    end
  end

  def log_out
    cookies.delete(:user_id)
    @current_user = nil
  end

  def current_user_can?(permission)
    @current_user && @current_user.can?(permission)
  end

  def ensure_not_suspended(user)
    # Redirect suspended users to the suspension page, don't allow anything else
    if user.suspended
      log_out
      raise Exceptions::SuspendedUserError
    end
  end

end
