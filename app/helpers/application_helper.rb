# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper   
  def money(amount)
    if amount < 0.0
      "($#{sprintf('%.02d', amount * -1)})"
    else
      "$#{sprintf('%.02d', amount)}"
    end
  end
end
