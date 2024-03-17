# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  describe '#add' do
    context 'when the input is empty' do
      it 'returns 0' do
        expect(calculator.add('')).to eq(0)
      end
    end

    context 'when the input is a single number' do
      it 'returns the number' do
        expect(calculator.add('5')).to eq(5)
      end
    end

    context 'when the input is two numbers' do
      it 'returns the sum of the numbers' do
        expect(calculator.add('5,7')).to eq(12)
      end
    end

    context 'when the input is unknown' do
      it 'returns the sum of the numbers' do
        expect(calculator.add('5,7,10,6,5,87')).to eq(120)
      end
    end

    context 'when string includes new line insted of `,`' do
      it 'returns the sum of the numbers' do
        expect(calculator.add("5\n7,10")).to eq(22)
      end
    end

    context 'when different delimiters are used' do
      it 'returns the sum of the numbers' do
        expect(calculator.add("//;\n1;2")).to eq(3)
      end
    end

    context 'when invalid string passed' do
      it 'raises an error' do
        expect { calculator.add("1,\n") }.to raise_error('Invalid input')
      end
    end

    context 'when negative numbers are passed' do
      it 'raises an error' do
        expect { calculator.add('1,-2') }.to raise_error('Negatives not allowed: -2')
      end
    end

    context 'when multiple negative numbers are passed' do
      it 'raises an error' do
        expect { calculator.add('1,-2,-3') }.to raise_error('Negatives not allowed: -2, -3')
      end
    end

    context 'when custom delimiter used and nagative number present' do
      it 'raises an error' do
        expect { calculator.add("//&\n1&-2") }.to raise_error('Negatives not allowed: -2')
      end
    end

    it 'supports multiple delimiters' do
      expect(calculator.add("//*%\n1*2%3")).to eq(6)
    end

    it 'supports multiple delimiters with any length' do
      expect(calculator.add("//***%%%\n1***2%%%3")).to eq(6)
    end
  end

  describe '#extract_delimiters' do
    context 'when custom delimiters are used' do
      it 'returns the custom delimiters' do
        delimiters = calculator.send(:extract_delimiters, "//;\n1;2")
        expect(delimiters).to eq(/,|\n|;/)
      end
    end
  end

  describe '#remaining_text' do
    context 'when custom delimiters are used' do
      it 'returns the remaining text' do
        remaining_text = calculator.send(:remaining_text, "//;\n1;2")
        expect(remaining_text).to eq('1;2')
      end
    end

    context 'when custom delimiter is `&`' do
      it 'returns the remaining text' do
        remaining_text = calculator.send(:remaining_text, "//&\n1&2")
        expect(remaining_text).to eq('1&2')
      end
    end
  end

  describe '#delimiter_regex' do
    it 'returns the delimiter regex' do
      regex = calculator.send(:delimiter_regex)
      expect(regex).to eq(%r{//(.*?)\n})
    end
  end
end
