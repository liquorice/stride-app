class AccessLevelsController < ApplicationController

  def index
    require_permission :accessLevels_modify
    @access_levels = @site.access_levels
  end

  def new
    require_permission :accessLevels_modify
    @access_level = @site.access_levels.new
  end

  def create
    require_permission :accessLevels_modify
    @access_level = @site.access_levels.new(access_level_params)

    if @access_level.save
      flash[:success] = "#{@access_level.name} succesfully created"
      redirect_to access_levels_path
    else
      flash.now[:error] = @access_level.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    require_permission :accessLevels_modify
    @access_level = @site.access_levels.find(params[:id])
  end

  def update
    @access_level = @site.access_levels.find(params[:id])

    if @access_level.update(access_level_params)
      flash[:success] = "#{@access_level.name} succesfully updated"
      redirect_to access_levels_path
    else
      flash.now[:error] = @access_level.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def access_level_params
    # Set the default to nothing, as it
    # is possible to have an access level with no permissions
    params[:permissions_data] ||= {}

    safe = params.require(:access_level).permit(:name)
    safe[:permissions_data] = params[:permissions_data]

    safe
  end

end
