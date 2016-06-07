class ChatSessionsController < ApplicationController
  layout 'modal', except: ['index', 'show', 'archived_list']

  def index
    @chat_sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']])
  end

  def archived_list
    @chat_sessions = @site.chat_sessions.where(status: [ChatSession.statuses['archived']]).paginate(:page => params[:page])
  end

  def show
    @chat_session = @site.chat_sessions.find(params[:id])
    require_user

    render @chat_session.status
  end

  def new
    require_permission :chat_modify
    @chat_session = @site.chat_sessions.new
  end

  def create
    require_permission :chat_modify
    @chat_session = @site.chat_sessions.new(chat_session_params)

    if @chat_session.save
      flash[:success] = "#{@chat_session.name} succesfully created"
      redirect_to chat_session_path(@chat_session)
    else
      flash.now[:error] = @chat_session.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    require_permission :chat_modify
    @chat_session = @site.chat_sessions.find(params[:id])
  end

  def update
    require_permission :chat_modify
    @chat_session = @site.chat_sessions.find(params[:id])

    if @chat_session.update(chat_session_params)
      flash[:success] = "#{@chat_session.name} succesfully updated"
      redirect_to chat_session_path(@chat_session)
    else
      flash.now[:error] = @chat_session.errors.full_messages.to_sentence
      render :edit
    end
  end

  # Live chat actions

  def start
    require_permission :chat_modify
    @chat_session = @site.chat_sessions.find(params[:id])

    @chat_session.start
    flash[:success] = "#{@chat_session.name} is now open"

    redirect_to chat_session_path(@chat_session)
  end

  def end
    require_permission :chat_modify
    @chat_session = @site.chat_sessions.find(params[:id])

    @chat_session.end
    flash[:success] = "#{@chat_session.name} is now closed"

    redirect_to chat_session_path(@chat_session)
  end

  def post
    require_permission :message_create
    @chat_session = @site.chat_sessions.find(params[:id])

    params[:queue] ||= []

    params[:queue].each do |index, queue_item|
      case queue_item['type']
      when 'message'
        @chat_session.chat_messages.create(
          content: queue_item['payload']['content'],
          user: @current_user
        )
      end
    end

    sent_at = Time.now.to_i
    last_seen = params[:last_seen].to_i || 0

    render json: {
      sent_at: sent_at,
      messages: @chat_session.message_data_since(last_seen)
    }
  end

  private

  def chat_session_params
    params.require(:chat_session).permit(
      :name,
      :description
    )
  end

end
