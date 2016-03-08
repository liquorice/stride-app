class LandingController < ApplicationController

  def admin
    require_permission :admin_view
    render layout: 'admin'
  end

end
