require 'rspec'
require_relative '../../lib/string_calculator'

RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  describe '#add' do
    context 'when the input is empty' do
      it 'returns 0' do
        expect(calculator.add("")).to eq(0)
      end
    end

    context 'when the input is a single number' do
      it 'returns the number' do
        expect(calculator.add("5")).to eq(5)
      end
    end

    context 'when the input is two numbers' do
      it 'returns the sum of the numbers' do
        expect(calculator.add("5,7")).to eq(12)
      end
    end

    context 'when the input is unknown' do
      it 'returns the sum of the numbers' do
        expect(calculator.add("5,7,10,6,5,87")).to eq(120)
      end
    end
  end
end
