class PostsController < ApplicationController

  def new
    require_permission :post_create

    @thread = @site.topic_threads.find(params[:id])
    @post = @thread.posts.new(user: @current_user, content: params[:content])

    # TODO catch post errors
    @post.save

    # TODO redirect to last page of posts
    redirect_to topic_thread_path(@thread)
  end

end
