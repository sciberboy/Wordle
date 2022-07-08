require 'colorize'

module Constants

  WORDS_LIST = './resources/common_words.txt'
  ALL_GREEN = %w[G G G G G]
  ALL_BLACK = %w[B B B B B]
  GREEN = 'G'
  YELLOW = 'Y'
  ATTEMPT_LIMIT = 6
  MESSAGE =
    {
      WORD_LENGTH: 'The word should be exactly 5 characters in length. Please try again.'.yellow,
      WORD_INVALID: 'The word you entered is not in the word list. Please try again.'.yellow,
      BYE: 'Thank you for playing!'.yellow
  }

end
