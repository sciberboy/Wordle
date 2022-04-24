#!/usr/bin/env ruby
require_relative './../config/config'
require_relative './../lib/wordle'

if $PROGRAM_NAME == __FILE__
  word = File.readlines(Constants::WORDS).sample.chomp
  Wordle.new(word).play
end
