class AddOrdinalToAccessLevels < ActiveRecord::Migration[4.2]
  def change
    add_column :access_levels, :ordinal, :integer
  end
end
