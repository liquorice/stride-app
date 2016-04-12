class TopicThread < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :posts

  scope :preview, -> { where(public: true).limit(4) }

  default_scope { order(pinned: :desc) }

  self.per_page = 8

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
      puts page_number
      return page_number if ids_for_page.include?(post_id)
    end

    nil
  end
end
