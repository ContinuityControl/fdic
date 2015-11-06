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
          #JSON::Validator.validate! will return true if it is successful, or raise if there is an error. Swallow true and return nil otherwise
          nil
        end

        protected

        def response
          @response ||= Client.new.send(client_method, *client_method_arguments)
        end
      end
    end
  end
end
