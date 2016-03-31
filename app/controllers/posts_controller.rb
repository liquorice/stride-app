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

  def toggle_visibility
    require_permission :post_moderate
    @post = @site.posts.find(params[:id])

    if @post.visible
      @post.update(visible: false, hidden_at: Time.now)
      flash[:success] = "Post succesfully hidden"
    else
      @post.update(visible: true, hidden_at: nil)
      flash[:success] = "Post successfully unhidden"
    end

    # TODO redirect to correct page for post
    redirect_to topic_thread_path(@post.topic_thread)
  end

end
