class AddOrdinalToAccessLevels < ActiveRecord::Migration
  def change
    add_column :access_levels, :ordinal, :integer
  end
end
