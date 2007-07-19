class CreateHousemates < ActiveRecord::Migration
  def self.up
    create_table :housemates do |t|
      t.column :person_id, :integer
    end
  end

  def self.down
    drop_table :housemates
  end
end
