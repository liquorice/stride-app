class TopicsController < ApplicationController
  layout 'modal', except: ['preview', 'show']

  # Public

  def preview
    @topics = @site.topics
  end

  def show
    @topic = @site.topics.find(params[:id])

    # Restrict access to hidden topics
    unless @topic.visible?
      unless current_user_can?(:topics_viewHidden)
        raise Exceptions::NotFoundError
      end
    end

    @threads = @topic.topic_threads.where(public: true).paginate(:page => params[:page])
  end

  # Admin

  def manage
    require_permission :forums_modify
    @topics = @site.topics
  end

  def update_order
    require_permission :forums_modify

    params[:topics_visible] ||= {}

    params[:topics_order].each_with_index do |topic_id, index|
      visible = params[:topics_visible][topic_id].present?
      @site.topics.find(topic_id.to_i).update(ordinal: index, visible: visible)
    end

    flash[:success] = "Forums succesfully updated"
    redirect_to topics_preview_path

    params[:topics_order].inspect
  end

  def new
    require_permission :topics_modify
    @topic = @site.topics.new
  end

  def create
    require_permission :topics_modify
    @topic = @site.topics.new(topic_params)

    if @topic.save
      flash[:success] = "#{@topic.name} succesfully created"
      redirect_to topics_preview_path
    else
      flash.now[:error] = @topic.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    require_permission :topics_modify
    @topic = @site.topics.find(params[:id])

    render :edit
  end

  def update
    require_permission :topics_modify
    @topic = @site.topics.find(params[:id])

    if @topic.update(topic_params)
      flash[:success] = "#{@topic.name} succesfully updated"
      redirect_to topic_path(@topic)
    else
      flash.now[:error] = @topic.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end
