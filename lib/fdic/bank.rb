module FDIC
  class Bank < Record
    field :fdic_id, 'id'
    field(:legal_name, 'legalName', &:strip)
    field :certificate_number, :certNumber
    field(:active?, 'activeFlag') { |value| value == 'Y' }
    field :address
    field :city
    field :state
    field :zip
    field :office_count, :officeCount
    date_field :effective_date, :effectiveDate

    def find_institution!
      @institution ||= FDIC.find_institution(certificate_number)
    end

    def find_history_events!
      @history_events ||= FDIC.find_history_events(legal_name, certificate_number)
    end

    def find_branches!
      @branches ||= FDIC.find_branches(certificate_number)
    end
  end
end
