# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  layout 'global'

  before_filter :get_current_chores

  protected
  def get_current_chores
    if logged_in?
      @current_chores = logged_in_person.app_profile.current_chores
    else
      @current_chores = []
    end
  end
end
