class UsersController < ApplicationController

  def index
    require_permission :users_view

    @access_levels = @site.access_levels
  end

  def show
    require_permission :users_view

    @user = @site.users.find(params[:id])
  end


end
