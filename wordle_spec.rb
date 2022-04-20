require_relative 'wordle'
require 'stringio'

module IoTestHelpers
  def simulate_stdin(*inputs, &block)
    io = StringIO.new
    inputs.flatten.each {|str| io.puts(str) }
    io.rewind

    actual_stdin, $stdin = $stdin, io
    yield
  ensure
    $stdin = actual_stdin
  end
end

class Wordle_test < Minitest
  include 'IoTestHelpers'

  describe 'Wordle' do
    wordle = Wordle.new(%[w o r d s])
    simulate = IoTestHelpers.simulate_stdin(%w[sword wordd words])

    it ("Expects the score to be Y Y Y Y Y") do
      expect(wordle.evaluate_guess(gets.chomp.downcase)).must_equal simulate[0]
      $stdin = STDIN # restore the original value
    end
  end
end
