class ApiController < ApplicationController
  include ActionView::Helpers::DateHelper
  include ApplicationHelper

  after_action :cors_set_access_control_headers

  def index
    api_result = Rails.cache.fetch("#{@site.name}_api", :expires_in => 1.hour){
      default_url = "https://#{request.host.gsub(/forums\./, "")}/api"
      api_url = Rails.configuration.api_url || default_url
      uri = URI(api_url)
      result = JSON.parse(Net::HTTP.get(uri))
    }
   render json: api_result
  end

  def threads_for_tag
    threads = @site.topic_threads.visible.for_tag(params[:tag])
    render json: threads.map(&:export_to_json)
  end

  def threads_for_query
    threads = @site.topic_threads.visible.for_query(params[:query])
    render json: threads.map(&:export_to_json)
  end

  def sessions_for_tag
    sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']]).for_tag(params[:tag])
    render json: sessions.map(&:export_to_json)
  end

  def sessions_for_query
    sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']]).for_query(params[:query])
    render json: sessions.map(&:export_to_json)
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
        status: ((chat_session.status if chat_session.open?) || ("upcoming" if (chat_session.scheduled_for <= 1.day.from_now)) || chat_session.status)
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

  private

  def cors_set_access_control_headers
    response.headers["Access-Control-Allow-Origin"] = request.headers["origin"]
    response.headers["Access-Control-Allow-Methods"] = "GET"
    response.headers['Access-Control-Allow-Credentials'] = "true"
  end


end
