class AccessLevel < ActiveRecord::Base
  belongs_to :site
  has_many :users

  validates :name, presence: true
  validates :site, presence: true

  default_scope { order(ordinal: :asc) }

  def self.permissions_list
    # Load permissions_list from file
    @permissions_list ||= YAML.load_file(
      Rails.root.join('config', 'access_permissions.yml')
    )
  end

  def permissions
    # permissions_data is a json hash of values, which
    # may over time contain keys that are no longer in @permissions_list
    # So we duplicate @permissions_list, and match it against permissions_data
    # to ensure we only deal with valid and up-to-date permissions
    @permissions ||= AccessLevel.permissions_list.deep_dup.extract!(*permissions_data.keys)
  end

end
