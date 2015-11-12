module FDIC
  module BankFind
    class Client
      include HTTParty
      base_uri 'https://odata.fdic.gov/v1/financial-institution/'
      format :json

      #logger ::Logger.new 'httparty.log', :debug, :curl
      #debug_output

      def find_bank(bank_name)
        check_response(self.class.get('/Bank',
                       query:
                       { '$inlinecount' => 'all',
                         '$format' => 'json',
                         '$filter' => "(substringof('#{escape_single_quotes(bank_name.upcase)}',name))"}))
      end

      def find_institution(certificate_number)
        check_response(self.class.get('/Institution',
                       query:
                       { '$inlinecount' => 'all',
                         '$format' => 'json',
                         '$filter' => "certNumber eq #{certificate_number}"}))
      end

      def find_branches(certificate_number)
        check_response(self.class.get('/Branch',
                       query:
                       { '$inlinecount' => 'allpages',
                         '$format' => 'json',
                         '$filter' => "certNumber eq #{certificate_number}"}))
      end

      def find_history_events(bank_name, certificate_number)
        filter = "legalName eq '#{escape_single_quotes(bank_name.upcase)}' and certNumber eq #{certificate_number}"
        check_response(self.class.get('/History',
                       query:
                       { '$inlinecount' => 'all',
                         '$format' => 'json',
                         '$filter' => filter}))
      end

      private

      def check_response(resp)
        case resp.code
        when 200...300
          resp
        when 500...600
          raise FDIC::Exceptions::ServerError
        end
      end

      def escape_single_quotes(string)
        # Urm? The API 500's if you have a single-quote in name: "People's United Bank."
        # Their web forms double-up the single-quotes to escape them.
        # NB: let's keep an eye on this flim-flam, and be sure it doesn't get out of hand.
        string.gsub("'", "''")
      end
    end
  end
end
