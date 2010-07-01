# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  before_filter :get_current_chores

  protected
  def get_current_chores
    if current_housemate
      @current_chores = current_housemate.current_chores
    else
      @current_chores = []
    end
  end
end
