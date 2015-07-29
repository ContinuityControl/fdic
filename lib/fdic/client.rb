module FDIC
  class Client
    include HTTParty
    base_uri 'https://odata.fdic.gov/v1/financial-institution/'
    format :json

    #logger ::Logger.new 'httparty.log', :debug, :curl
    #debug_output

    def find_bank(bank_name)
      self.class.get('/Bank',
                     query:
                     { '$inlinecount' => 'all',
                       '$format' => 'json',
                       '$filter' => "(substringof('#{bank_name.upcase}',name))"})
    end

    def find_institution(certificate_number)
      self.class.get('/Institution',
                     query:
                     { '$inlinecount' => 'all',
                       '$format' => 'json',
                       '$filter' => "certNumber eq #{certificate_number}"})
    end

    def find_branches(certificate_number)
      self.class.get('/Branch',
                     query:
                     { '$inlinecount' => 'allpages',
                       '$format' => 'json',
                       '$filter' => "certNumber eq #{certificate_number}"})
    end

    def find_history_events(bank_name, certificate_number)
      filter = "legalName eq '#{bank_name.upcase}' and certNumber eq #{certificate_number}"
      self.class.get('/History',
                     query:
                     { '$inlinecount' => 'all',
                       '$format' => 'json',
                       '$filter' => filter})
    end
  end
end
