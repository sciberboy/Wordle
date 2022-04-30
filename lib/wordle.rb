require_relative './../config/config'
require_relative './colors'

class Wordle
  include Colors
  attr_accessor  :score

  def initialize(word_of_the_day = '')
    @characters_of_the_day = word_of_the_day.downcase.chars
    @attempt = 1
    @score = []
    @history = []
  end

  def play
    until score == Constants::ALL_GREEN || attempt == Constants::ATTEMPT_LIMIT
      reset_score
      banner
      evaluate_guess(guess)
      add_to_history
      increment
      print_score
    end
    print_history
    puts Constants::BYE
  end

  def evaluate_guess(guess_word)
    characters_of_the_day.each_index do |index|
      @score[index] = Constants::YELLOW if characters_of_the_day.include? guess_word[index]
      @score[index] = Constants::GREEN if guess_word[index] == characters_of_the_day[index]
    end
  end

  def valid_word?(word)
    lines = File.readlines(Constants::WORDS_FILE)
    lines.each do |line|
      return true if line.chomp == word
    end
    false
  end

  private

  attr_accessor :attempt, :history
  attr_reader :characters_of_the_day

  def add_to_history
    @history << score.join(' ')
  end

  def increment
    @attempt += 1
  end

  def reset_score
    @score = Constants::ALL_BLACK
  end

  def banner
    puts "Attempt #{attempt}: Guess a word...".green
  end

  def print_score
    Colors.add_color(score).map { |color| print color << '|' }
    puts
  end

  def print_history
    history.each { |the_score| puts the_score }
    puts
    puts
  end

  def guess
    word = gets.chomp.downcase
    if word == 'x' || word == 'q'
      puts Constants::BYE
      exit(1)
    elsif word.length != 5
      puts Constants::WORD_LENGTH
      play
    elsif !valid_word?(word)
      puts Constants::WORD_INVALID
      play
    else
      word.chars
    end
  end

end
