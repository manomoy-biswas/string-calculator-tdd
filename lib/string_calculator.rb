class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    return numbers.to_i if numbers.length == 1

    numbers = numbers.split(',').map(&:to_i)
    numbers[0] + numbers[1]
  end
end
