class MainController < ApplicationController
  def index
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
