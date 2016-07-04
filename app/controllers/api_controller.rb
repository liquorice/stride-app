class ApiController < ApplicationController
  include ActionView::Helpers::DateHelper
  include ApplicationHelper

  # TODO JUST FOR TESTING cors_set_access_control_headers is just for testing, to make the API work cross domain, please remove/update for launch
  after_filter :cors_set_access_control_headers

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email'
  end

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
        scheduled_for: chat_session.scheduled_for.to_i,
        starts_in: distance_of_future_time_in_words(chat_session.scheduled_for),
        status: chat_session.status
      }
    else
      chat = false;
    end

    render json: { chat: chat }
  end

  def forums_overview
    topics = []
    @site.topics.visible.first(2).each do |topic|
      threads = []
      @topic_threads = topic
          .topic_threads
          .visible
          .where(pinned: false)
          .by_activity
          .limit(2)

      @topic_threads.each do |topic_thread|
        threads.push({
          data: topic_thread.export_to_json
        })
      end

      topics.push({
        name: topic.name,
        url: topic_path(topic),
        threads: threads
      })
    end

    render json: topics
  end

end
