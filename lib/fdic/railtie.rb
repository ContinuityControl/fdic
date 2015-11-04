require 'fdic'
require 'rails'
module FDIC
  class Railtie < Rails::Railtie
    rake_tasks do
      FDIC::FDICTasks.new.install_tasks
    end
  end
end
