require_relative './../config/config'
require 'minitest/autorun'
require 'wordle'

class Wordle_test < Minitest::Test

  def test_input_greater_than_expected
    game = Wordle.new
    game.guess = 'beginner'
    assert_equal (puts Constants::WORD_LENGTH), game.manage_flow
  end

  def test_word_is_less_than_five_characters
    game = Wordle.new
    game.guess = ('more')
    assert_equal (puts Constants::WORD_LENGTH), game.manage_flow
  end

  def test_guesss_is_words
    game = Wordle.new
    game.guess = 'words'
    game.word_of_the_day = 'words'
    game.evaluate_guess
    assert_equal %w[G G G G G], game.score
  end

  def test_guess_is_watch
    game = Wordle.new
    game.guess = 'watch'
    game.word_of_the_day = 'match'
    game.evaluate_guess
    assert_equal %w[B G G G G], game.score
  end

  def test_word_is_not_in_wordlist
    game = Wordle.new
    game.guess = ('xxxxx')
    assert_equal false, game.valid_word?
  end

  def test_word_is_in_wordlist
    game = Wordle.new
    game.guess = ('sword')
    assert_equal true, game.valid_word?
  end

end
