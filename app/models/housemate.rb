class Housemate < ActiveRecord::Base
  belongs_to :person
  
  def balance
    b = 0.0
    Charge.find_all_by_creditor_id(person.id) do |c|
      b += c.balance(person)
    end
    Charge.find_all_by_debtor_id(person.id) do |c|
      b += c.balance(person)
    end
    return b
  end
end
