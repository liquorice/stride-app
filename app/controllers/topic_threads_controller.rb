class TopicThreadsController < ApplicationController
  layout 'modal', except: ['show', 'hidden']
  impressionist actions: ['show']

  # Public

  def show
    @thread = @site.topic_threads.find(params[:id])

    # Only show thread if it is public, or if the user can edit threads
    unless @thread.public?
      unless current_user_can?(:topicThreads_modify)
        raise Exceptions::NotFoundError
      end
    end

    @posts = @thread.posts_for_page(params[:page])
    @topic = @thread.topic
  end

  def hidden
    require_permission :topicThreads_modify
    @threads = @site.topic_threads.where(public: false)
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
      flash[:success] = "#{@thread.name} successfully created"

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
      flash[:success] = "#{@thread.name} successfully updated"
      redirect_to topic_thread_path(@thread)
    else
      flash.now[:error] = @thread.errors.full_messages.to_sentence
      render :edit
    end
  end

  def toggle_pin
    require_permission :topicThreads_modify
    @thread = @site.topic_threads.find(params[:id])
    fragment = ''

    if @thread.pinned
      @thread.update(pinned: false)
      flash[:success] = "#{@thread.name} successfully unpinned"
    else
      @thread.update(pinned: true)
      flash[:success] = "#{@thread.name} successfully pinned"
      fragment = "#pinned-#{@thread.id}"
    end

    redirect_to "#{topic_path(@thread.topic)}#{fragment}"
  end

  private

  def thread_params
    params.require(:topic_thread).permit(
      :name,
      :locked,
      :public,
      :topic_id,
      :similar_thread_check,
      :tags => []
    )
  end

end
