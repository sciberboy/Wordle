source 'https://rubygems.org'
ruby '3.0.0'

group :development, :production do
  %w[
    minitest
    rubocop
    rubocop-minitest
    simplecov
  ].each { |package| gem package }
end

group :production do
  %w[
    colorize
  ].each { |package| gem package }
end


