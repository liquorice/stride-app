class AddSubjectTitleToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :subject_title, :string, default: ""
  end
end
