class TopicThread < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  is_impressionable :counter_cache => true
  # --- Associations ---
  belongs_to :topic
  belongs_to :user
  has_many :posts

  scope :preview, -> { where(public: true).limit(4) }
  scope :visible, -> { where(public: true) }
  default_scope { order(pinned: :desc, created_at: :desc) }

  scope :by_activity, -> {
    joins(:posts)
    .group('topic_threads.id')
    .order('max(posts.created_at) DESC')
  }

  # --- Validations ---
  validates :name, presence: true, length: { minimum: 2 }
  validate :must_perform_similar_thread_check
  before_save :cleanup_tags

  self.per_page = 8

  def self.for_tag(tag)
    where("? = ANY (tags)", tag)
  end

  def self.for_query(query)
    where("topic_threads.name ilike ?", "%#{query}%")
  end

  def topic_visible?
    topic.visible?
  end

  def posts_count
    posts.count
  end

  def posts_for_page(page_number = 1)
    posts.paginate(page: page_number)
  end

  def total_post_pages
    p = posts_for_page

    (p.total_entries / p.per_page).ceil
  end

  def page_for_post(post)
    post_id = post.id

    (0..total_post_pages).each do |i|
      page_number = i + 1
      ids_for_page = posts_for_page(page_number).pluck(:id)
      return page_number if ids_for_page.include?(post_id)
    end

    nil
  end

  def latest_post
    posts.visible.last
  end

  def export_to_json
    json = {
      id: id,
      name: name,
      created_at: created_at.to_i,
      created_by: user.name,
      views: impressions_count,
      posts: ("#{posts_count / 1000}k" if posts_count > 1000 ) || posts_count,
    }

    if latest_post
      json[:last_post] = {
        id: latest_post.id,
        user: latest_post.user.name,
        avatar_face: latest_post.user.avatar_face,
        avatar_colour: latest_post.user.avatar_colour,
        created_at: time_ago_in_words(latest_post.created_at, locale: 'en-brief'),
        content: latest_post.content
      }
    end

    json
  end

  private

  def cleanup_tags
    if self.tags
      self.tags = self.tags.map(&:strip).reject(&:blank?).uniq
    end
  end

  def must_perform_similar_thread_check
    unless similar_thread_check
      errors.add(:base, 'must check that no similar threads exist')
    end
  end

end

