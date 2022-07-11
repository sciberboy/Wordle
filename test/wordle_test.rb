require_relative './../config/config'
require 'minitest/autorun'
require_relative './../bin/Wordle'
require 'wordle_game'

class Wordle_test < Minitest::Test
  include Constants

  def test_banner_output
    game = WordleGame.new
    game.send(:attempt=, 4)
    assert_equal "Attempt 4", game.send(:start_banner)
  end

  def test_input_greater_than_expected
    game = WordleGame.new
    game.send(:guess=, 'beginner')
    assert_equal [false, MESSAGE[:word_length]], game.send(:manage_flow)
  end

  def test_input_invalid
    game = WordleGame.new
    game.send(:guess=, 'skool')
    assert_equal [false, MESSAGE[:word_invalid]], game.send(:manage_flow)
  end

  def test_word_is_less_than_five_characters
    game = WordleGame.new
    game.send(:guess=, 'more')
    assert_equal [false, MESSAGE[:word_length]], game.send(:manage_flow)
  end

  def test_guess_is_words
    game = WordleGame.new
    game.send(:guess=, 'words')
    game.send(:word_of_the_day=, 'words')
    game.send(:evaluate_guess)
    assert_equal %w[G G G G G], game.send(:score)
  end

  def test_guess_is_watch
    game = WordleGame.new
    game.send(:guess=, 'watch')
    game.send(:word_of_the_day=, 'match')
    game.send(:evaluate_guess)
    assert_equal %w[B G G G G], game.send(:score)
  end

  def test_word_is_not_in_wordlist
    game = WordleGame.new
    game.send(:guess=, 'xxxxx')
    assert_equal false, game.send(:valid_word?)
  end

  def test_word_is_in_wordlist
    game = WordleGame.new
    game.send(:guess=, 'sword')
    assert_equal true, game.send(:valid_word?)
  end

end
