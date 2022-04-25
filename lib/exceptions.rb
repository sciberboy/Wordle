module Exceptions
  # not used - purely for future custom exceptions if needed

  class Wordlength < ArgumentError
    def initialize(message = 'Words should be be exactly 5 characters')
      super
    end
  end
end
