class Wordle

  ALL_GREEN = %w[G G G G G]
  ALL_BLACK = %w[B B B B B]
  GREEN = 'G'
  YELLOW = 'Y'
  ATTEMPT_LIMIT = 6

  def initialize(word_of_the_day)
    @characters_of_the_day = word_of_the_day.downcase.chars
    @attempt = 1
    @score = []
    @history = []
  end

  def play
    until score == ALL_GREEN || attempt == ATTEMPT_LIMIT
      reset_score
      banner
      evaluate_guess(guess)
      add_to_history
      increment
      print_score
    end
    print_history
    puts 'Thank you for playing!'
  end

  attr_accessor :attempt, :score, :history
  attr_reader :characters_of_the_day

  def add_to_history
    @history << score.join(' ')
  end

  def increment
    @attempt += 1
  end

  def reset_score
    @score = ALL_BLACK
  end

  def banner
    puts "Attempt #{attempt}: Guess a word..."
  end

  def print_score
    p score
    puts
  end

  def print_history
    history.each { |the_score| p the_score }
    puts
  end

  def guess
    word = gets.chomp.downcase
    if word.length != 5
      raise StandardError.new 'Only 5 characters are allowed'
    else
      word.chars
    end
  end

  def evaluate_guess(guess_word)
    characters_of_the_day.each_index do |index|
      @score[index] = YELLOW if characters_of_the_day.include? guess_word[index]
      @score[index] = GREEN if guess_word[index] == characters_of_the_day[index]
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Wordle.new('words').play
end


