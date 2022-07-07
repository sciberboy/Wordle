require_relative './../config/config'

class Wordle

  attr_accessor :attempt,
                :guess,
                :score,
                :word_of_the_day

  def play
    until score == Constants::ALL_GREEN || attempt > Constants::ATTEMPT_LIMIT
      puts start_banner
      guess_word
      status, message = manage_flow
      puts message unless status
    end
    end_this_game
  end

  def start_banner
    "Attempt #{attempt}"
  end

  def guess_word
    self.guess = gets.chomp.downcase
  end

  def manage_flow
    if guess == 'x'
      end_this_game
    elsif guess.length != 5
      [false, Constants::WORD_LENGTH]
    elsif !valid_word?
      [false, Constants::WORD_INVALID]
    else
      evaluate_guess
      puts colorize
      puts color_map
      archive_score
      increment_attempt
      [true, '']
    end
  end

  def valid_word?
    dictionary.any? { |line| line.chomp == guess}
  end

  def evaluate_guess
    given = word_of_the_day.downcase.chars
    guessed = guess.chars
    self.score = %w[B B B B B]
    given.each_index do |index|
      self.score[index] = Constants::YELLOW if given.include? guessed[index]
      self.score[index] = Constants::GREEN if given[index] == guessed[index]
    end
  end

  def end_this_game
    end_banner
    play_again? ? Wordle.new.play : (puts Constants::BYE)
    exit!
  end

  private

  attr_accessor :archive,
                :dictionary

  def initialize(dictionary = File.readlines(Constants::WORDS_LIST))
    @dictionary = dictionary
    @word_of_the_day = dictionary.sample.downcase.chomp
    @attempt = 1
    @word = ''
    @score = []
    @archive = []
    puts "The word of the day is: #{word_of_the_day.green}" if $DEBUG
  end

  def archive_score
    self.archive << score
  end

  def increment_attempt
    self.attempt += 1
  end

  def color_map(colors = score)
    colormap = Colors.add_color(colors)
    colormap.map { |color| color << '|' }.join
  end

  def colorize
    guess.chars.map { |char| char }.join(' ').yellow
  end

  def retrieve_archive
    archive.map { |colors| color_map(colors) }
  end

  def end_banner
    puts
    puts 'History:'.yellow
    puts retrieve_archive
    response = score == Constants::ALL_GREEN ? 'Well done!' : 'Sorry, you did not get it this time!'
    puts <<~REPORT % [response, word_of_the_day.green]

      %s
      The word you are looking for is: %s

    REPORT
  end

  def play_again?
    puts 'Do you want to play again? (y/n)'
    true if gets.downcase.chomp == 'y'
  end
end
