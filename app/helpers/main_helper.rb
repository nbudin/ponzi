module MainHelper
  def frequencyize(number)
    if number == 1
      "once"
    elsif number == 2
      "twice"
    elsif number == 0
      "never"
    else
      "#{number} times"
    end
  end
end
