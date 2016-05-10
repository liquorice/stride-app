class TopicThreadsController < ApplicationController
  layout 'modal', except: ['show']

  # Public

  def show
    @thread = @site.topic_threads.find(params[:id])
    @posts = @thread.posts_for_page(params[:page])
    @topic = @thread.topic
  end

  # Admin

  def new
    require_permission :topicThreads_create
    @thread = @site.topic_threads.new
  end

  def create
    require_permission :topicThreads_create
    @thread = @current_user.topic_threads.new(thread_params)

    if @thread.save
      flash[:success] = "#{@thread.name} succesfully created"

      # If any post body was provided, attempt to create a new post
      first_post_content = params[:first_post]

      unless first_post_content.blank?
        @post = @thread.posts.new(user: @current_user, content: first_post_content)
        # TODO catch this potential error
        @post.save
      end

      redirect_to topic_thread_path(@thread)
    else
      flash.now[:error] = @thread.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    require_permission :topicThreads_modify
    @thread = @site.topic_threads.find(params[:id])
  end

  def update
    require_permission :topicThreads_modify
    @thread = @site.topic_threads.find(params[:id])

    if @thread.update(thread_params)
      flash[:success] = "#{@thread.name} succesfully updated"
      redirect_to topic_thread_path(@thread)
    else
      flash.now[:error] = @thread.errors.full_messages.to_sentence
      render :edit
    end
  end

  def toggle_pin
    require_permission :topicThreads_modify
    @thread = @site.topic_threads.find(params[:id])

    if @thread.pinned
      @thread.update(pinned: false)
      flash[:success] = "#{@thread.name} succesfully unpinned"
    else
      @thread.update(pinned: true)
      flash[:success] = "#{@thread.name} succesfully pinned"
    end

    redirect_to topic_path(@thread.topic)
  end

  private

  def thread_params
    params.require(:topic_thread).permit(
      :name,
      :locked,
      :public,
      :topic_id,
      :similar_thread_check
    )
  end

end
