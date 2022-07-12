require_relative './../config/config'

class WordleGame
  include Constants

  attr_accessor :score,
                :attempt

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
      [false, MESSAGE[:word_length]]
    elsif !valid_word?
      [false, MESSAGE[:word_invalid]]
    else
      evaluate_guess
      puts colorize
      puts color_map
      archive_score
      increment_attempt
      [true, '']
    end
  end

  def end_this_game
    end_banner
    play_again? ? Wordle.new.start : (puts MESSAGE[:bye])
    exit!
  end

  private

  attr_accessor :archive,
                :guess,
                :word_of_the_day

  attr_reader :dictionary

  def initialize(dictionary = File.readlines(WORDS_LIST))
    @dictionary = dictionary
    @word_of_the_day = dictionary.sample.downcase.chomp
    @attempt = 1
    @archive = []
    puts "The word of the day is: #{word_of_the_day.green}" if $DEBUG
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
    response = score == ALL_GREEN ? 'Well done!' : 'Sorry, you did not get it this time!'
    puts <<~REPORT % [response, word_of_the_day.green]

      %s
      The word you are looking for is: %s

    REPORT
  end

  def continue?(response, continue = ['y', ''])
    continue.include? response
  end

  def play_again?
    puts 'Do you want to play again? (Y/n)'
    continue? gets.downcase.chomp
  end


  def valid_word?
    dictionary.any? { |line| line.chomp == guess }
  end

  def evaluate_guess
    given = word_of_the_day.downcase.chars
    guessed = guess.chars
    self.score = %w[B B B B B]
    given.each_index do |index|
      score[index] = YELLOW if given.include? guessed[index]
      score[index] = GREEN if given[index] == guessed[index]
    end
  end

  def archive_score
    archive << score
  end

end
