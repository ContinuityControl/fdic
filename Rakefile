require "bundler/gem_tasks"
require "rspec/core/rake_task"
require './lib/tasks/fdic_tasks'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
Bundler::GemHelper.install_tasks
FDIC::FDICTasks.new.install_tasks
