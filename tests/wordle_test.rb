require_relative './../config/config'
require 'minitest/autorun'
require_relative './../lib/wordle'

class Wordle_test < Minitest::Test
  def $stdin.gets(count)
    @stubbed_input = %w[spacer sword wordw words]
    @stubbed_input[count]
  end

  def test_sword_first_guess
    game = Wordle.new('words')
    game.evaluate_guess($stdin.gets(1))
    assert_equal %w[Y Y Y Y Y], game.score
  end

  def test_wordw_second_guess
    game = Wordle.new('words')
    game.evaluate_guess($stdin.gets(2))
    assert_equal %w[G G G G Y], game.score
  end

  def test_words_third_guess
    game = Wordle.new('words')
    game.evaluate_guess($stdin.gets(3))
    assert_equal %w[G G G G G], game.score
  end

  def test_without_stdin
    game = Wordle.new('words')
    game.evaluate_guess('words')
    assert_equal %w[G G G G G], game.score
  end

end
