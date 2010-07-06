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
  
  def each_charge_with_running_balance(charges, housemate, starting_balance = 0.0, &block)
    balance = case starting_balance
      when Money
        starting_balance
      else
        Money.new(starting_balance)
    end
    with_output_buffer do
      charges.each do |charge|
        content = with_output_buffer do 
          logger.debug balance
          block.call(charge, balance)
        end
        balance -= charge.balance(housemate)
        output_buffer << content
      end
    end
  end
end
