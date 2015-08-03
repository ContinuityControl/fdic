module FDIC
  class Institution < Record
    field :fdic_id, :id
    field(:legal_name, :legalName, &:strip)
    field :certificate_number, :certNumber
    field(:active?, 'activeFlag') { |value| value == 'Y' }
    date_field :inactive_as_of_date, "inActiveAsofDt"
    field :address
    field :city
    field :county
    field :state
    field :zip
    field :web_site, "webSite"

    date_field :insured_date, 'insuredDate'
    date_field :insured_from_date, "insuredFrmDt"
    date_field :insured_to_date, "insuredToDt"
    date_field :established_date, 'establishedDate'
    date_field :as_of_date, 'asOfDate'

    date_field :report_date, "reportDate"  # This is NOT the date the query was made.

    int_field :office_count, "officeCount"
    currency_field :total_assets_in_thousands, 'totalAssets'
    currency_field :total_deposits_in_thousands, "totalDeposits"
    currency_field :domestic_deposits_in_thousands, "domesticDeposits"
    currency_field :bank_equity_capital_in_thousands, "bankEquityCapital"

    def find_history_events!
      @history_events ||= FDIC.find_history_events(legal_name, certificate_number)
    end

    def find_branches!
      @branches ||= FDIC.find_branches(certificate_number)
    end

    def find_bank!
      @bank ||= FDIC.find_bank(legal_name)
    end
  end
end
