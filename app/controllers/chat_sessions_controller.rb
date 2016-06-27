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

    @chat_session.start(@current_user)
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
    @chat_session = @site.chat_sessions.find(params[:id])
    @chat_messages = @chat_session.chat_messages

    # Ensure the chat session is currently open
    unless @chat_session.open?
      render json: {
        status: 'archived'
      }
      return
    end

    # Defaults
    queue = params[:queue] || []
    last_seen = params[:last_seen] || -1

    # Init empty payload
    payload = {}

    case params[:task]
    when "history"
      # Retrieve all messages until now
      messages = @chat_messages.since(-1)
    when "view_only"
      # Retrieve all messages until now
      messages = @chat_messages.since(last_seen)
    when "update"
      # Process the pending queue, and send back
      # all new messages, including private messages,
      # and excluding messages made by the user

      # This is only available to priveledged users
      require_permission :message_create

      process_queue

      # Retrieve new messages for the user
      messages = @chat_messages.since(last_seen).for_user(@current_user)
    end

    # Add any messages to payload
    if messages.any?
      payload[:messages] = messages.map(&:to_data)
      payload[:last_seen] = messages.last.id
    end

    # Add the timestamp so that the duration can be updated
    payload[:timestamp] = Time.now.to_i

    render json: payload
  end

  private

  def process_queue
    queue = params[:queue] || []

    queue.each do |index, queue_item|
      case queue_item["type"]
      when "message"
        # Create new message
        @chat_session.chat_messages.create(
          content: queue_item["payload"]["content"],
          user: @current_user
        )
      when "delete"
        # Remove message
        # Moderators only
        require_permission :chat_modify

        @chat_session.chat_messages.find_by(
          id: queue_item["payload"]["message_id"]
        ).destroy
      end
    end
  end

  def chat_session_params
    safe = params.require(:chat_session).permit(
      :name,
      :discreet_name,
      :description,
      :notes,
      :tags => []
    )

    safe[:scheduled_for] = ChatSession.scheduled_for_from_date_and_time(
      params[:chat_session][:scheduled_for_date],
      params[:chat_session][:scheduled_for_time]
    )

    safe
  end

end
