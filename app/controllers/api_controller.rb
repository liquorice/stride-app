class ApiController < ApplicationController

  def threads_for_tag
    threads = @site.topic_threads.visible.for_tag(params[:tag])
    render json: threads.map(&:export_to_json)
  end

end
