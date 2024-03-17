class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    return numbers.to_i if numbers.length == 1
  end
end
