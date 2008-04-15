class CreateHouses < ActiveRecord::Migration
  def self.up
    create_table :houses do |t|
      t.string :name
      t.timestamps
    end
    house = House.create :name => "Default House"
    
    create_table :housemates_houses, :id => false do |t|
      t.integer :house_id
      t.integer :housemate_id
    end
    house.housemates += Housemate.find(:all)
    
    add_column :chore_groups, :house_id, :integer
    house.chore_groups += ChoreGroup.find(:all)
    
    house.save
  end

  def self.down
    remove_column :chore_groups, :house_id
    drop_table :housemates_houses
    drop_table :houses
  end
end
