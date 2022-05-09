require_relative './../config/config'

class Wordle

  attr_accessor  :score
  attr_reader :word_of_the_day, :dictionary

  def initialize(dictionary = File.readlines(Constants::WORDS_LIST))
    @dictionary = dictionary
    @word_of_the_day = dictionary.sample.chomp
    @characters_of_the_day = word_of_the_day.downcase.chars
    @attempt = 1
    @score = []
    @archive = []
    puts "The word of the day is: #{word_of_the_day.green}" if $DEBUG
  end

  def play
    until score == Constants::ALL_GREEN || attempt > Constants::ATTEMPT_LIMIT
      start_banner
      user_input
      show_score
      archive_score
      increment_attempt
    end
    end_banner
    play_again? ? Wordle.new.play : (puts Constants::BYE)
    exit(1)
  end

  def valid_word?(word)
    dictionary.any? { |line| line.chomp == word }
  end

  def evaluate(user_guess)
    @score = %w[B B B B B]
    characters_of_the_day.each_index do |index|
      @score[index] = Constants::YELLOW if characters_of_the_day.include? user_guess[index]
      @score[index] = Constants::GREEN if user_guess[index] == characters_of_the_day[index]
    end
    user_guess
  end

  private

  attr_accessor :attempt, :archive
  attr_reader :characters_of_the_day, :dictionary

  def start_banner
    puts
    puts "Attempt #{attempt}"
  end

  def user_input
    evaluate(guess).each {|character| print character.yellow << ' '}
    puts
  end

  def guess
    word = gets.chomp.downcase
    if word == 'x'
      end_banner
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

  def archive_score
    @archive << score
  end

  def increment_attempt
    @attempt += 1
  end

  def show_score(colors = score)
    colormap = Colors.add_color(colors)
    colormap.each { |color| print color << '|' }
    puts
  end

  def retrieve_archive
    archive.each do |colors|
      show_score(colors)
    end
  end

  def end_banner
    puts
    puts "H i s t o r y:".yellow
    retrieve_archive
    puts
    puts <<~EOS
    #{score == Constants::ALL_GREEN ? 'Well done!' : 'Sorry, you did not get it this time!'}
    The word you are looking for is: #{word_of_the_day.green}
    EOS
  end

  def play_again?
    puts 'Do you want to play again? (y/n)'
    true if gets.downcase.chomp == 'y'
  end

end
