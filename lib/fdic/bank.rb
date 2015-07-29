module FDIC
  class Bank < Record
    field :fdic_id, 'id'
    field(:legal_name, 'legalName', &:strip)
    field :cert_number, :certNumber
    field(:active?, 'activeFlag') { |value| value == 'Y' }
    field :address
    field :city
    field :state
    field :zip
    field :office_count, :officeCount
    date_field :effective_date, :effectiveDate

    def institution
      FDIC.find_institution(cert_number).first
    end
  end
end
