=begin
{ "__metadata"=> {
    "uri"=>"http://odata.fdic.gov:80/v1/financial-institution/Branch('10345')",
    "type"=>"financial-institutionModel.Branch"
    },
  "id"=>"10345",
  "branchName"=>"First National Bank Alaska",
  "certNumber"=>"16130",
  "address"=>"101 W. 36th Avenue",
  "city"=>"Anchorage",
  "county"=>"Anchorage",
  "state"=>"AK",
  "zip"=>"99510.0",
  "branchNum"=>nil,
  "establishedDate"=>"1922-01-30 00:00:00.0",
  "acquiredDate"=>nil,

  "fiUninum"=>"10345",
  "servTypeCd"=>"11"
}
=end

module FDIC
  class Branch < Record
    field :fdic_id, 'id'
    field(:branch_name, 'branchName', &:strip)
    field :certificate_number, :certNumber

    field :address
    field :city
    field :county
    field :state
    field :zip

    field :branch_number, :branchNum
    date_field :established_date, :establishedDate
    date_field :acquired_date, :acquiredDate
  end
end
