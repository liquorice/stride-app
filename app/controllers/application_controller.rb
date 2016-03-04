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

  private

  def check_for_user
    logged_in?
  end

  def require_site
    @site = Site.find_by_host(request.host)
    raise Exceptions::NotFoundError unless @site
  end

  def not_found
    render(:file => File.join(Rails.root, 'public/404.html'), :status => 404, :layout => false)
  end

end
