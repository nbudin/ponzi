class MainController < ApplicationController
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
end
