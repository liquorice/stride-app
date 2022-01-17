class PostsController < ApplicationController

  def new
    require_permission :post_create

    @thread = @site.topic_threads.find(params[:id])

    # Test that quoted post exists in thread
    quoted_post = @thread.posts.visible.where(id: params[:quoted_post_id])
    quoted_post_id = quoted_post.any? ? quoted_post.first.id : nil

    @post = @thread.posts.new(
      user: @current_user,
      content: params.permit(:content)[:content],
      quoted_post_id: quoted_post_id
    )

    if @thread.locked
      flash[:error] = "Posts can not be added to locked threads"
      return redirect_to topic_thread_path(@thread)
    end

    unless @thread.public
      flash[:error] = "Posts can not be added to hidden threads"
      return redirect_to topic_thread_path(@thread)
    end

    # TODO catch post errors
    @post.save

    flash[:success] = "Posts successfully created"
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
      flash[:success] = "Post successfully hidden"
    else
      @post.update(visible: true, hidden_at: nil)
      flash[:success] = "Post successfully shown"
    end

    redirect_to @post.direct_path
  end

end
