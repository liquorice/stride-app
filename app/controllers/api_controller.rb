class ApiController < ApplicationController

  def threads_for_tag
    threads = @site.topic_threads.visible.for_tag(params[:tag])
    render json: threads.map(&:export_to_json)
  end

  def current_user
    if @current_user
      user_details = {
        name: @current_user.name,
        avatar_colour: @current_user.processed_avatar_colour,
        avatar_face: @current_user.avatar_face
      }
    else
      user_details = false
    end

    render json: { user: user_details }
  end

end
