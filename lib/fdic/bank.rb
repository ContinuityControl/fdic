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
      @institution ||= FDIC.find_institution(certificate_number).first
    end
  end
end
