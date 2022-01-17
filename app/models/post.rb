class Post < ApplicationRecord
  # URL helpers needed for building direct_path
  include Rails.application.routes.url_helpers

  belongs_to :topic_thread
  belongs_to :user

  default_scope { order(created_at: :asc) }
  scope :visible, -> { where(visible: true) }

  self.per_page = 8

  def direct_path
    thread_path = topic_thread_path(topic_thread)
    thread_page = topic_thread.page_for_post(self)

    "#{thread_path}?page=#{thread_page}#post-#{id}"
  end

  def preview_snippet
    content.split('.').first
  end

  def hidden?
    !visible
  end

  def quoted_post
    Post.where(id: quoted_post_id).first
  end

end
