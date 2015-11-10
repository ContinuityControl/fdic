module FDIC
  module BankFind
    module SchemaValidators
      class BankValidator < BaseValidator
        private
        def schema
          File.join(File.dirname(__FILE__), '../schemas/bank_response_schema.json')
        end

        def client_method
          :find_bank
        end

        def client_method_arguments
          'thomaston savings bank'
        end
      end
    end
  end
end
