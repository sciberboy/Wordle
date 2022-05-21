require_relative './../config/config'
require 'minitest/autorun'
require 'wordle'

class Wordle_test < Minitest::Test

  def test_guesss_is_words
    game = Wordle.new
    game.evaluate('words', 'words')
    assert_equal %w[G G G G G], game.score
  end

  def test_guess_is_watch
    game = Wordle.new
    game.evaluate('watch', 'match')
    assert_equal %w[B G G G G], game.score
  end

  def test_word_is_not_in_wordlist
    assert_equal false, Wordle.new.valid_word?('xxxxx')
  end

  def test_word_is_in_wordlist
    assert_equal true, Wordle.new.valid_word?('sword')
  end

end