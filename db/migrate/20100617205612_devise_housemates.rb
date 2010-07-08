require 'ae_users_migrator/import'

class DeviseHousemates < ActiveRecord::Migration
  def self.up
    # Ensure we can map each person ID to a housemate
    person_ids = Charge.group(:creditor_id).map(&:creditor_id)
    person_ids += Charge.group(:debtor_id).map(&:debtor_id)
    person_ids = person_ids.uniq.compact

    person_ids_to_create = []
    person_ids.each do |person_id|
      unless Housemate.find_by_person_id(person_id)
        person_ids_to_create << person_id
      end
    end
    
    total_migrations = Housemate.count + person_ids_to_create.count
    if total_migrations > 0 && !File.exist?("ae_users.json")
      raise "There are users to migrate, and ae_users.json does not exist.  Please use export_ae_users.rb to create it."
    else
      dumpfile = AeUsersMigrator::Import::Dumpfile.load(File.new("ae_users.json"))
    end
    
    change_table :housemates do |t|
      t.cas_authenticatable
      t.trackable
      
      t.string :firstname
      t.string :lastname
      t.string :email
    end
    
    Housemate.reset_column_information
    
    person_ids_to_create.each do |person_id|
      Housemate.create(:person_id => person_id, :username => "auto-generated-person-id-#{person_id}",
        :firstname => "Unknown (person ID #{person_id})")
    end
    
    # Convert person IDs to housemate IDs
    execute "update charges, housemates set charges.debtor_id = housemates.id where charges.debtor_id = housemates.person_id"
    execute "update charges, housemates set charges.creditor_id = housemates.id where charges.creditor_id = housemates.person_id"
    
    Housemate.all.each do |housemate|
      person = dumpfile.people[housemate.person_id]
      raise "Couldn't find ae_users person record for id #{housemate.person_id}" unless person

      housemate.firstname = person.firstname
      housemate.lastname = person.lastname
      email = person.primary_email_address.try(:address)
      housemate.email = email
      housemate.username = email
      
      housemate.save
    end
    
    add_index :housemates, :username, :unique => true
    remove_column :housemates, :person_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
