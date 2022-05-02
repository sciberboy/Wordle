require_relative './../config/config'
require 'minitest/autorun'
require_relative './../lib/wordle'

class Wordle_test < Minitest::Test

  def $stdin.gets(count)
    @stubbed_input = %w[spacer sword wordw words match cross slime slime ]
    @stubbed_input[count]

  end

  def test_stdin_guess_is_wordw
    game = Wordle.new('words')
    game.evaluate_guess($stdin.gets(2))
    assert_equal %w[G G G G Y], game.score
  end

  def test_stdin_guess_is_match
    game = Wordle.new('watch')
    game.evaluate_guess($stdin.gets(4))
    assert_equal %w[B G G G G], game.score
  end

  def test_without_stdin
    game = Wordle.new('words')
    game.evaluate_guess('words')
    assert_equal %w[G G G G G], game.score
  end

  def test_guess_is_words
    game = Wordle.new('words')
    game.evaluate_guess('words')
    assert_equal %w[G G G G G], game.score
  end

  def test_guess_is_watch
    game = Wordle.new('match')
    game.evaluate_guess('watch')
    assert_equal %w[B G G G G], game.score
  end

  def test_guess_is_gross
    game = Wordle.new('gloss')
    game.evaluate_guess('gross')
    assert_equal %w[G B G G G], game.score
  end

  def test_guess_is_abeam
    game = Wordle.new('abdul')
    game.evaluate_guess('abeam')
    assert_equal %w[G G B Y B], game.score
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