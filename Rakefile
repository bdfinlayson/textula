#!/usr/bin/env ruby
## -*- ruby -*-

require 'rake/clean'
require 'rake/testtask'
require 'minitest/autorun'

task :default => :test

Rake::TestTask.new() do |config|
  config.pattern = "tests/test_*.rb"
  end
