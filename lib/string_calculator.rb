class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    # keeping this conditional return to avoid split, map and sum operation for single digit string
    return numbers.to_i if numbers.length == 1

    numbers.split(',').map(&:to_i).sum
  end
end
