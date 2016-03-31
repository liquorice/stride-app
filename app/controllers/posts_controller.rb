class PostsController < ApplicationController

  def new
    require_permission :post_create

    @thread = @site.topic_threads.find(params[:id])
    @post = @thread.posts.new(user: @current_user, content: params[:content])

    # TODO catch post errors
    @post.save

    redirect_to @post.direct_path
  end

  def show
    @post = @site.posts.find(params[:id])
    redirect_to @post.direct_path
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

    redirect_to @post.direct_path
  end

end
