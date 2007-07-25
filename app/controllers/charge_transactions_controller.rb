class ChargeTransactionsController < ApplicationController
  # GET /charge_transactions
  # GET /charge_transactions.xml
  def index
    @charge_transactions = ChargeTransaction.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @charge_transactions.to_xml }
    end
  end

  # GET /charge_transactions/1
  # GET /charge_transactions/1.xml
  def show
    @charge_transaction = ChargeTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @charge_transaction.to_xml }
    end
  end

  # GET /charge_transactions/new
  def new
    @charge_transaction = ChargeTransaction.new
  end

  # GET /charge_transactions/1;edit
  def edit
    @charge_transaction = ChargeTransaction.find(params[:id])
  end

  # POST /charge_transactions
  # POST /charge_transactions.xml
  def create
    @charge_transaction = ChargeTransaction.new(params[:charge_transaction])
    if params[:transaction]
      # they used the form on main/index
      t = params[:transaction]
      
      @charge_transaction.description = t[:description]
      
      amount = t[:amount].to_f
      t[:other_people].each do |p|
        other = Person.find p
        charge = Charge.new
        if t[:is_creditor] == '0'
          charge.debtor = session[:account].person
          charge.creditor = other
        elsif t[:is_creditor] == '1'
          charge.creditor = session[:account].person
          charge.debtor = other
        else
          flash[:error_messages] = ["You must select who paid in the transaction."]
          redirect_to :controller => :main, :action => :index
        end
        
        charge.amount = amount / (t[:other_people].length)
        charge.save
        @charge_transaction.charges.push charge
      end
      
      @charge_transaction.save
    end

    respond_to do |format|
      if @charge_transaction.save
        flash[:notice] = 'ChargeTransaction was successfully created.'
        format.html { redirect_to :controller => "main", :action => "index" }
        format.xml  { head :created, :location => charge_transaction_url(@charge_transaction) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @charge_transaction.errors.to_xml }
      end
    end
  end

  # PUT /charge_transactions/1
  # PUT /charge_transactions/1.xml
  def update
    @charge_transaction = ChargeTransaction.find(params[:id])

    respond_to do |format|
      if @charge_transaction.update_attributes(params[:charge_transaction])
        flash[:notice] = 'ChargeTransaction was successfully updated.'
        format.html { redirect_to charge_transaction_url(@charge_transaction) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @charge_transaction.errors.to_xml }
      end
    end
  end

  # DELETE /charge_transactions/1
  # DELETE /charge_transactions/1.xml
  def destroy
    @charge_transaction = ChargeTransaction.find(params[:id])
    @charge_transaction.destroy

    respond_to do |format|
      format.html { redirect_to charge_transactions_url }
      format.xml  { head :ok }
    end
  end
end
