class CreateChores < ActiveRecord::Migration
  def self.up
    create_table :chores do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :frequency_amount, :integer
      t.column :frequency_unit, :string
    end
  end

  def self.down
    drop_table :chores
  end
end
