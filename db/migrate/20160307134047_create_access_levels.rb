class CreateAccessLevels < ActiveRecord::Migration
  def change
    create_table :access_levels do |t|
      t.references :site, index: true, foreign_key: true
      t.string :name
      t.json :permissions_data, default: {}

      t.timestamps null: false
    end
  end
end
