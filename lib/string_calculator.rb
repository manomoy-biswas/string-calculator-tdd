# frozen_string_literal: true

# class to calculate sum of digits in a string
class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    raise 'Invalid input' if numbers.match(/,\n/)

    # keeping this conditional return to avoid split, map and sum operation for single digit string
    return numbers.to_i if numbers.length == 1

    delimiters = extract_delimiters(numbers)
    numbers = remaining_text(numbers) if numbers.start_with?('//')
    handle_negative_numbers(numbers)
    numbers.split(delimiters).map(&:to_i).sum
  end

  def get_called_count
  end

  private

  def extract_delimiters(numbers)
    delimiters = [',', "\n"]
    if numbers.start_with?('//')
      custom_delimiters = numbers.match(delimiter_regex).captures[0].split('').uniq
      delimiters += custom_delimiters if custom_delimiters
    end
    Regexp.union(delimiters)
  end

  def remaining_text(numbers)
    numbers.match(delimiter_regex).post_match
  end

  def delimiter_regex
    %r{//(.*?)\n}
  end

  def handle_negative_numbers(numbers)
    negative_numbers = numbers.scan(/-\d+/)
    raise "Negatives not allowed: #{negative_numbers.join(', ')}" if negative_numbers.any?
  end
end
