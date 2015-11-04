require 'httparty'
require 'logger'
require 'fdic/version'
require 'fdic/bank_find'
require 'tasks/fdic_tasks'

module FDIC
  require "fdic/railtie" if defined?(Rails)
end

