require 'fdic'
module FDIC
  class FDICTasks
    include Rake::DSL if defined? Rake::DSL
    def install_tasks
      namespace :fdic do
        desc "Verify Schema"
        task(:validate_schema!) do
          ::FDIC::BankFind.validate_schema!
        end
      end
    end
  end
end
