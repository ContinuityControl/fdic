require 'json-schema'
module FDIC
  module BankFind
    module SchemaValidators
      class BaseValidator
        def schema_valid?
          JSON::Validator.validate(schema, response)
        end

        def schema_valid!
          JSON::Validator.validate!(schema, response)
        end

        protected

        def response
          @response ||= Client.new.send(client_method, *client_method_arguments)
        end
      end
    end
  end
end
