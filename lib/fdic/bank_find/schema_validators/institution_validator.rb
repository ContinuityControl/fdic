module FDIC
  module BankFind
    module SchemaValidators
      class InstitutionValidator < BaseValidator
        private
        def schema
          File.join(File.dirname(__FILE__), '../schemas/institution_response_schema.json')
        end

        def client_method
          :find_institution
        end

        def client_method_arguments
          '18258'
        end
      end
    end
  end
end
