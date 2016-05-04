class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Ensure we can determine which site this is
  before_action :require_site

  # Manage session and user log-ins
  include SessionsHelper
  before_action :check_for_user

  # Catch 404 errors
  rescue_from Exceptions::NotFoundError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Exceptions::NotAuthorisedError, with: :not_authorised
  private

  def check_for_user
    logged_in?
  end

  def require_site
    @host = request.host
    @site = Site.find_by_host(request.host)
    raise Exceptions::NotFoundError unless @site
  end

  def require_permission(permission)
    # Require permission via an access level
    # Otherwise, 403
    unless @current_user && @current_user.can?(permission)
      raise Exceptions::NotAuthorisedError
    end
  end

  def require_user
    # Require a logged in user of any access level
    # Otherwise, 403
    unless @current_user
      raise Exceptions::NotAuthorisedError
    end
  end

  def require_existence(object)
    # Check that an object/model exists
    # If not, 404
    raise Exceptions::NotFoundError if object.nil?
  end

  def not_found
    render(:file => File.join(Rails.root, 'public/404.html'), :status => 404, :layout => false)
  end

  def not_authorised
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
  end

end
