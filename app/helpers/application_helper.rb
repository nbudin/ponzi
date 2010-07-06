# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper   
  def money(amount)
    if amount < 0.0
      "(#{(amount * -1).format})"
    elsif amount > 0.0
      "#{amount.format}"
    else
      "$0.00"
    end
  end
  
  def display_balance(amount)
    c = ''
    if amount < 0.0
      c = 'debt'
    elsif amount > 0.0
      c = 'credit'
    end
    
    return "<span class=\"#{c}\">#{money amount}</span>".html_safe
  end
end
