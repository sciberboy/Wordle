require_relative './../config/config'
require 'minitest/autorun'
require_relative './../lib/wordle'

class Wordle_test < Minitest::Test
  def $stdin.gets(count)
    @stubbed_input = %w[spacer sword wordw words match cross]
    @stubbed_input[count]
  end

  def test_stdin_guess_is_wordw
    skip
    game = Wordle.new('words')
    game.reset_score
    game.evaluate_guess($stdin.gets(2))
    assert_equal %w[G G G G Y], game.score
    puts game.score
  end

  def test_stdin_guess_is_match
    skip
    game = Wordle.new('watch')
    game.reset_score
    game.evaluate_guess($stdin.gets(5))
    assert_equal %w[B G G G G], game.score
    puts game.score
  end

  def test_guess_is_words
    skip
    game = Wordle.new('words')
    game.reset_score
    game.evaluate_guess('words')
    assert_equal %w[G G G G G], game.score
  end

  def test_guess_is_watch
    skip
    game = Wordle.new('match')
    game.reset_score
    game.evaluate_guess('watch')
    assert_equal %w[B G G G G], game.score
  end

  def test_guess_is_gross
    skip
    game = Wordle.new('gloss')
    game.reset_score
    game.evaluate_guess('gross')
    assert_equal %w[G B G G G], game.score
  end

  def test_guess_is_abeam
    game = Wordle.new('abdul')
    game.reset_score
    game.evaluate_guess('abeam')
    assert_equal %w[G G B Y B], game.score
  end

  def test_word_is_not_in_wordlist
    skip
    game = Wordle.new
    assert_equal false, game.valid_word?('xxxxx')
  end

  def test_word_is_in_wordlist
    skip
    game = Wordle.new
    assert_equal true, game.valid_word?('sword')
  end

end
