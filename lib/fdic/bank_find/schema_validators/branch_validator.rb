module FDIC
  module BankFind
    module SchemaValidators
      class BranchValidator < BaseValidator
        private
        def schema
          './lib/fdic/bank_find/schemas/branch_response_schema.json'
        end

        def client_method
          :find_branches
        end

        def client_method_arguments
          '18258'
        end
      end
    end
  end
end
