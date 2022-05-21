require_relative './../config/config'

class Wordle

  attr_accessor :attempt, :archive, :score
  attr_reader :characters_of_the_day, :dictionary
  attr_reader  :dictionary, :word_of_the_day

  def initialize(dictionary = File.readlines(Constants::WORDS_LIST))
    @dictionary = dictionary
    @word_of_the_day = dictionary.sample.chomp
    @attempt = 1
    @score = []
    @archive = []
    puts "The word of the day is: #{word_of_the_day.green}" if $DEBUG
  end

  def play
    until score == Constants::ALL_GREEN || attempt > Constants::ATTEMPT_LIMIT
      start_banner
      word = gets.chomp.downcase
      if word == 'x'
        end_this_game
      elsif word.length != 5
        puts Constants::WORD_LENGTH
      elsif !valid_word?(word)
        puts Constants::WORD_INVALID
      else
        evaluate(word)
        show_score
        archive_score
        increment_attempt
      end
    end
    end_this_game
  end

  def end_this_game
    end_banner
    play_again? ? Wordle.new.play : (puts Constants::BYE)
    exit!
  end

  def valid_word?(word)
    dictionary.any? { |line| line.chomp == word }
  end


  def evaluate(user_guess, word = word_of_the_day)
    guess = user_guess.downcase.chars
    todays_characters = word.downcase.chars
    @score = %w[B B B B B]
    todays_characters.each_index do |index|
      @score[index] = Constants::YELLOW if todays_characters.include? guess[index]
      @score[index] = Constants::GREEN if guess[index] == todays_characters[index]
    end
    user_guess
  end


  def start_banner
    puts
    puts "Attempt #{attempt}"
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
    archive.each { |colors| show_score(colors) }
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
