class AddTimingPreferences < ActiveRecord::Migration
  def self.up
    add_column "chores", "forced_timing", :integer
    add_column "housemates", "preferred_hour", :integer
    add_column "housemates", "preferred_dow", :integer
  end

  def self.down
    remove_column "chores", "forced_timing"
    remove_column "housemates", "preferred_hour"
    remove_column "housemates", "preferred_dow"
  end
end
