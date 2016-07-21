class NotificationsController < ApplicationController
  include ApplicationHelper
  layout 'modal', except: ['history']

  def history
    require_permission :notification_create
    @notifications = @site.notifications
  end

  def new
    require_permission :notification_create

    @chat_sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']])
    @articles = fetch_articles
  end

  def proof
    require_permission :notification_create

    @content_type = params[:content_type].to_sym
    raise Exceptions::NotFoundError unless Notification.content_types.include?(@content_type)

    @notification_data = params[:notification][:data]
    @notification_content = Notification.send(@content_type, *[@site, @notification_data])
  end

  def create
    require_permission :notification_create

    @content_type = params[:notification][:content_type].to_sym
    raise Exceptions::NotFoundError unless Notification.content_types.include?(@content_type)

    @notification_data = params[:notification][:data]
    @notification_content = Notification.send(@content_type, *[@site, @notification_data])

    @notification = @current_user.notifications.create(
      content: @notification_content,
      content_type: @content_type
    )

    @notification.dispatch(@host)

    flash[:success] = "Notification has been created"
    redirect_to notifications_history_path
  end

  private

  def fetch_articles
    api_url = link_to_kb("api")
    api_raw = open(api_url).read
    api_data = JSON.parse(api_raw)
    api_data["articles"]
  end

end
