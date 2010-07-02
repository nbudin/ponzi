class MainController < ApplicationController

  before_filter :force_login, :except => [:login]
  
  def index
    @houses = current_housemate.houses
    if @houses.length == 1
      redirect_to :action => "house", :id => @houses[0].id
    end
  end
  
  def login
    redirect_to :action => "index" if housemate_signed_in?
  end
  
  def house
    @house = House.find(params[:id])
    @people = @house.housemates
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
    @me = current_housemate
    @other = Housemate.find(params[:other])
    charges = Charge.between(@me, @other).latest_first
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
    @me = current_housemate
    @other = Housemate.find(params[:other])
    
    t = ChargeTransaction.new :description => "Settling debt"
    c = Charge.new :charge_transaction => t
    
    @balance = @me.relative_balance(@other)
    c.amount = @balance.abs
    
    if @balance < 0.0
      c.creditor = @me
      c.debtor = @other
    else
      c.creditor = @other
      c.debtor = @me
    end
    
    c.save
    t.save
  end
  
  protected
  def force_login
    redirect_to :action => :login unless housemate_signed_in?
  end
end
