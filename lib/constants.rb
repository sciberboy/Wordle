module Constants

  WORDS = './resources/wordlist.txt'
  ALL_GREEN = %w[G G G G G]
  ALL_BLACK = %w[B B B B B]
  GREEN = 'G'
  YELLOW = 'Y'
  ATTEMPT_LIMIT = 6

end

module Exceptions
  class Wordlength < ArgumentError
    def initialize(message = 'Words should be be exactly 5 characters')
      super
    end
  end
end

