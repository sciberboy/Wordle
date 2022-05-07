require_relative './../config/config'

class Wordle

  attr_accessor  :score

  def initialize(word_of_the_day = '')
    @characters_of_the_day = word_of_the_day.downcase.chars
    @attempt = 1
    @score = []
    @history = []
  end

  def self.play
    word = File.readlines(Constants::WORDS_LIST).sample.chomp
    puts "The word of the day is: #{word.green}" if $DEBUG
    Wordle.new(word).wordle
  end

  def wordle
    until score == Constants::ALL_GREEN || attempt > Constants::ATTEMPT_LIMIT
      banner
      word = evaluate(guess)
      word.each {|character| print character.yellow << ' '}
      puts
      add_to_history
      increment
      show_score
      puts
    end
    puts
    puts "H i s t o r y:".yellow
    show_history
    puts
    puts score == Constants::ALL_GREEN ? 'Well done!' : 'Sorry, you did not get it this time!'
    puts "The word you are looking for is: #{characters_of_the_day.join.green}"
    puts 'Do you want to play again? (y/n)'
    Wordle.play if gets.downcase.chomp == 'y'
    puts Constants::BYE
    exit(1)
  end

  def evaluate(guess_word)
    @score = %w[B B B B B]
    characters_of_the_day.each_index do |index|
      @score[index] = Constants::YELLOW if characters_of_the_day.include? guess_word[index]
      @score[index] = Constants::GREEN if guess_word[index] == characters_of_the_day[index]
    end
    guess_word
  end

  def valid_word?(word)
    lines = File.readlines(Constants::WORDS_LIST)
    lines.each do |line|
      return true if line.chomp == word
    end
    false
  end

  private

  attr_accessor :attempt, :history
  attr_reader :characters_of_the_day

  def add_to_history
    @history << score
  end

  def increment
    @attempt += 1
  end

  def banner
    puts
    puts "Attempt #{attempt}"
  end

 def show_score(colors = score)
   colormap = Colors.add_color(colors)
   colormap.each { |color| print color << '|' }
 end

  def show_history
    history.each do |colors|
      show_score(colors)
      puts
    end
  end

  def guess
    word = gets.chomp.downcase
    puts
    if word == 'x' || word == 'q'
      puts Constants::BYE
      exit(1)
    elsif word.length != 5
      puts Constants::WORD_LENGTH
      wordle
    elsif !valid_word?(word)
      puts Constants::WORD_INVALID
      wordle
    else
      word.chars
    end
  end

end
