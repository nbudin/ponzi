require File.dirname(__FILE__) + '/../test_helper'
require 'ponzi_controller'

# Re-raise errors caught by the controller.
class PonziController; def rescue_action(e) raise e end; end

class PonziControllerTest < Test::Unit::TestCase
  def setup
    @controller = PonziController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
