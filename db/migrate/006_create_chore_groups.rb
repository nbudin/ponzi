class CreateChoreGroups < ActiveRecord::Migration
  def self.up
    create_table :chore_groups do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :initial_assignee_id, :integer
      t.column :initial_assignment_time, :datetime
    end
    create_table :chore_groups_chores, :id => false do |t|
      t.column :chore_id, :integer
      t.column :chore_group_id, :integer
    end
  end

  def self.down
    drop_table :chore_groups_chores
    drop_table :chore_groups
  end
end
