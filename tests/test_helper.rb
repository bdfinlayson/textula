require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
require 'minitest/autorun'

reporter_options = { color: true }

Minitest::Reporters.use!
[Minitest::Reporters::DefaultReporter.new(reporter_options)]

def main_menu
  "1. Add room\n2. Quit\n"
end

