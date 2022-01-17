class AddSubjectTitleToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :subject_title, :string, default: ""
  end
end
