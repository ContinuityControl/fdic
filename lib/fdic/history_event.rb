module FDIC
  class HistoryEvent < Record

    field :fdic_id, :id
    field(:legal_name, :legalName, &:strip)
    field :certificate_number, :certNumber

    date_field :effective_date, :orgEffDate
    field :event_description, :eventDescription
    field :change_code, :changeCode
    field :change_description, :changeDesc

    field :trust_power, :trustPower
    field :trust_power_check, :trustPowerCheck

    field :city
    field :state

    field :primary_regulatory_agency_check, :primaryRegulatoryAgencyCheck
    field :primary_regulatory_agency, :primaryRegulatoryAgency
  end
end
