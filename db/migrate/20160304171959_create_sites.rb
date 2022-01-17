class CreateSites < ActiveRecord::Migration[4.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :hosts, array: true, default: []

      t.timestamps null: false
    end
  end
end
