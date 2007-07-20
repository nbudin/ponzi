require File.dirname(__FILE__) + '/../test_helper'
require 'charge_transactions_controller'

# Re-raise errors caught by the controller.
class ChargeTransactionsController; def rescue_action(e) raise e end; end

class ChargeTransactionsControllerTest < Test::Unit::TestCase
  fixtures :charge_transactions

  def setup
    @controller = ChargeTransactionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:charge_transactions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_charge_transaction
    old_count = ChargeTransaction.count
    post :create, :charge_transaction => { }
    assert_equal old_count+1, ChargeTransaction.count
    
    assert_redirected_to charge_transaction_path(assigns(:charge_transaction))
  end

  def test_should_show_charge_transaction
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_charge_transaction
    put :update, :id => 1, :charge_transaction => { }
    assert_redirected_to charge_transaction_path(assigns(:charge_transaction))
  end
  
  def test_should_destroy_charge_transaction
    old_count = ChargeTransaction.count
    delete :destroy, :id => 1
    assert_equal old_count-1, ChargeTransaction.count
    
    assert_redirected_to charge_transactions_path
  end
end
