class TopicThreadsController < ApplicationController

  def show
    @thread = @site.topic_threads.find(params[:id])
  end

end
