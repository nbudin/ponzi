# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include LoginEngine
  helper :user
  model :user
  
  before_filter :login_required
end
