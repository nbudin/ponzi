class MainController < ApplicationController
  require_login
  
  def index
    @people = Housemate.find(:all).collect { |h| h.person }
    @debt = {}
    @people.each do |p|
      balances = {}
      @people.each do |o|
        balances[o] = 0.0
      end
      Charge.find_all_by_debtor_id(p).each do |c|
        if balances.has_key? c.creditor
          balances[c.creditor] += c.balance(p)
        end
      end
      Charge.find_all_by_creditor_id(p).each do |c|
        if balances.has_key? c.debtor
          balances[c.debtor] += c.balance(p)
        end
      end
      @debt[p] = balances
    end
    @transactions = ChargeTransaction.find :all
    
    @choregroups = ChoreGroup.find :all
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
    @me = session[:account].person
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
    @me = Housemate.find_by_person_id(session[:account].person)
    @other = Housemate.find_by_person_id(params[:other])
    
    t = ChargeTransaction.new :description => "Settling debt"
    c = Charge.new :charge_transaction => t
    
    @balance = @me.relative_balance(@other)
    c.amount = @balance
    
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
