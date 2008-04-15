class MainController < ApplicationController
  require_login
  
  def index
    @houses = logged_in_person.housemate.houses
    if @houses.length == 1
      redirect_to :action => "house", :id => @houses[0].id
    end
  end
  
  def house
    @house = House.find(params[:id])
    @people = @house.housemates.collect { |h| h.person }    
    @choregroups = @house.chore_groups
  end
  
  def new_transaction
    @users = params[:other_users].collect do |ou|
      Person.find(ou)
    end
    @amount = params[:amount].to_f
  end
  
  def create_transaction
    @amounts = params[:amount]
    total_amount = 0.0
    @amounts.each_value do |value|
      total_amount += value.to_f
    end
    if total_amount != params[:total].to_f
      @flash[:errors] = "Those amounts don't add up to $#{params[:total]}.  Try again."
      redirect_to :action => :new_transaction
    end
  end
  
  def explain_balance
    @me = logged_in_person
    @other = Person.find(params[:other])
    charges = Charge.find_by_sql(["select * from charges left join charge_transactions t on charges.transaction_id = t.id where (creditor_id = ? and debtor_id = ?) or (debtor_id = ? and creditor_id = ?) order by t.created_at",
      @other, @me, @other, @me])
    @charges = []
    @balance = 0.0
    charges.each do |charge|
      @charges.push charge
      @balance += charge.balance(@me)
      if @balance == 0.0
        @charges = []
      end
    end
  end
  
  def settle
    @me = Housemate.find_by_person_id(logged_in_person)
    @other = Housemate.find_by_person_id(params[:other])
    
    t = ChargeTransaction.new :description => "Settling debt"
    c = Charge.new :charge_transaction => t
    
    @balance = @me.relative_balance(@other.person)
    c.amount = @balance.abs
    
    if @balance < 0.0
      c.creditor = @me.person
      c.debtor = @other.person
    else
      c.creditor = @other.person
      c.debtor = @me.person
    end
    
    c.save
    t.save
  end
end
