module FDIC
  module BankFind
    module SchemaValidators
      class HistoryEventValidator < BaseValidator
        private
        def schema
          './lib/fdic/bank_find/schemas/history_event_response_schema.json'
        end

        def client_method
          :find_history_events
        end

        def client_method_arguments
          ['thomaston savings bank', '18258']
        end
      end
    end
  end
end
