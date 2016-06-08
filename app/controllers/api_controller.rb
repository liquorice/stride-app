class ApiController < ApplicationController

  def threads_for_tag
    threads = @site.topic_threads.visible.for_tag(params[:tag])
    render json: threads.map(&:export_to_json)
  end

  def current_user
    if @current_user
      user_details = {
        name: @current_user.name,
        avatar_colour: @current_user.processed_avatar_colour,
        avatar_face: @current_user.avatar_face
      }
    else
      user_details = false
    end

    render json: { user: user_details }
  end

  def upcoming_chat
    @chat_sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']])
    if @chat_sessions.any?
      chat_session = @chat_sessions.first
      chat = {
        name: chat_session.name,
        description: chat_session.description,
        url: chat_session_path(chat_session),
        scheduled_for: chat_session.scheduled_for,
        status: chat_session.status
      }
    else
      chat = false;
    end

    render json: { chat: chat }
  end

end
