class TopicsController < ApplicationController
  layout 'admin', except: ['preview', 'show']

  # Public

  def preview
    @topics = @site.topics
  end

  def show
    @topic = @site.topics.find(params[:id])
  end

  # Admin

  def index
    require_permission :topics_modify
    @topics = @site.topics
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
      redirect_to topics_path
    else
      flash.now[:error] = @topic.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    require_permission :topics_modify
    @topic = @site.topics.find(params[:id])
  end

  def update
    @topic = @site.topics.find(params[:id])

    if @topic.update(topic_params)
      flash[:success] = "#{@topic.name} succesfully updated"
      redirect_to topics_path
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
