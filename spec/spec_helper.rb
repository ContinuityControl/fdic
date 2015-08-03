$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fdic'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
