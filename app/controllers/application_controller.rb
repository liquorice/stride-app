class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Manage session and user log-ins
  include SessionsHelper
  before_action :check_for_user

  private

  def check_for_user
    logged_in?
  end
end
