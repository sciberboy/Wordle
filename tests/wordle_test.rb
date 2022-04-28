require_relative './../config/config'
require 'minitest/autorun'
require_relative './../lib/wordle'

class Wordle_test < Minitest::Test

  def $stdin.gets(count)
    @stubbed_input = %w[spacer sword wordw words]
    @stubbed_input[count]
  end

  def test_stdin_gets_wordw
    game = Wordle.new('words')
    game.evaluate_guess($stdin.gets(2))
    assert_equal %w[G G G G Y], game.score
    puts game.score
  end

  def test_without_stdin
    game = Wordle.new('words')
    game.evaluate_guess('words')
    assert_equal %w[G G G G G], game.score
  end

  def test_word_is_not_in_wordlist
    game = Wordle.new
    assert_equal false, game.valid_word?('xxxxx')
  end

  def test_word_is_in_wordlist
    game = Wordle.new
    assert_equal true, game.valid_word?('sword')
  end

end
