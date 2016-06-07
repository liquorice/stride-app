class ChatSessionsController < ApplicationController
  layout 'modal', except: ['index', 'show']

  def index
    @chat_sessions = @site.chat_sessions
  end

  def show
    @chat_session = @site.chat_sessions.find(params[:id])
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

  private

  def chat_session_params
    params.require(:chat_session).permit(
      :name,
      :description
    )
  end

end
