class PrivateChatSessionsController < ApplicationController

  def show
    @chat_session = @site.private_chat_sessions.find(params[:id])
    require_participant
    require_permission :chat_modify if @chat_session.archived?
    render @chat_session.status
  end

  def post
    @chat_session = @site.private_chat_sessions.find(params[:id])
    @chat_messages = @chat_session.chat_messages

    require_participant

    # Ensure the chat session is currently open
    unless @chat_session.open?
      render json: {
        status: 'archived'
      }
      return
    end

    # Defaults
    queue = params[:queue] || []
    last_seen = params[:last_seen_message] || -1

    # Init empty payload
    payload = {}

    case params[:task]
    when "history"
      # Retrieve all messages until now
      messages = @chat_messages.since(-1)
    when "update"
      # Process the pending queue, and send back
      # all new messages, including private messages,
      # and excluding messages made by the user
      process_queue

      # Retrieve new messages for the user
      messages = @chat_messages.since(last_seen).for_user(@current_user)
    end

    # Add any messages to payload
    if messages.any?
      payload[:messages] = messages.map(&:to_data)
      payload[:last_seen_message] = messages.last.id
    end

    # Add the timestamp so that the duration can be updated
    payload[:timestamp] = Time.now.to_i

    render json: payload
  end

  # Live chat actions

  def end
    @chat_session = @site.private_chat_sessions.find(params[:id])

    require_permission :chat_modify
    require_participant

    @chat_session.end
    flash[:success] = "Private chat between #{@chat_session.moderator.name} and #{@chat_session.participants.name} is now closed"

    redirect_to private_chat_path(@chat_session)
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
      end
    end
  end

  def require_participant
    unless @current_user && @chat_session.participants.include?(@current_user)
      raise Exceptions::NotAuthorisedError
    end
  end

end
