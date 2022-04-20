require_relative 'wordle'

class TestInput
  def gets
    @stubbed_input ||= %w[sword wordd words]
    @stubbed_input.shift
  end
end

class Wordle_test < Minitest

  describe 'Wordle' do
    wordle_characters = %w[w o r d s]
    $stdin = TestInput.new
    wordle = Wordle.new(wordle_characters)


    it ("Expects the score to be Y Y Y Y Y") do
      expect(wordle.evaluate_guess(gets.chomp.downcase)).must_equal wordle_characters
      $stdin = STDIN # restore the original value
    end
  end
end
