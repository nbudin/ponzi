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
  
  def explain_balance
    @me = current_housemate
    @other = Housemate.find(params[:other])
    @charges = Charge.between(@me, @other).latest_first.all
    @balance = @me.relative_balance(@other)
  end
  
  def settle
    @me = current_housemate
    @other = Housemate.find(params[:other])
    
    t = ChargeTransaction.new :description => "Settling debt"
    c = Charge.new :charge_transaction => t
    
    @balance = @me.relative_balance(@other)
    c.amount = Money.new(@balance.cents.abs, @balance.currency)
    
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
