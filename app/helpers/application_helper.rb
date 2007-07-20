# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper   
  def money(amount)
    if amount < 0.0
      "($#{sprintf('%0.02d', amount * -1)})"
    elsif amoutn > 0.0
      "$#{sprintf('%0.02d', amount)}"
    end
  end
  
  def display_balance(amount)
    c = ''
    if amount < 0.0
      c = 'debt'
    elsif amount > 0.0
      c = 'credit'
    end
    
    return "<span class=\"#{c}\">#{money amount}</span>"
  end
end
