class CreateChoreGroupCandidates < ActiveRecord::Migration
  def self.up
    create_table :chore_group_candidates do |t|
      t.column :position, :integer
      t.column :chore_group_id, :integer
      t.column :housemate_id, :integer
    end
    remove_column "chore_groups", "initial_assignee_id"
  end

  def self.down
    add_column "chore_groups", "initial_assignee_id", :integer
    ChoreGroup.find(:all).each do |cg|
      cg.initial_assignee = cg.candidates[0]
      cg.save
    end
    drop_table :chore_group_candidates
  end
end
