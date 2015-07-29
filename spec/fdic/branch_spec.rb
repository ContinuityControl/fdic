require 'spec_helper'

describe FDIC::Branch do
  let(:api_result) {
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
  }

  let(:branch) { FDIC::Branch.new(api_result) }

  it 'parses data out correctly' do
    expect(branch.fdic_id).to eq('10345')
    expect(branch.branch_name).to eq('First National Bank Alaska')
    expect(branch.certificate_number).to eq('16130')
    expect(branch.address).to eq('101 W. 36th Avenue')
    expect(branch.city).to eq('Anchorage')
    expect(branch.county).to eq('Anchorage')
    expect(branch.state).to eq('AK')
    expect(branch.zip).to eq('99510.0')
    expect(branch.branch_number).to be_nil
    expect(branch.established_date).to eq(Date.new(1922, 1, 30))
    expect(branch.acquired_date).to be_nil
    expect(branch.uri).to eq("http://odata.fdic.gov:80/v1/financial-institution/Branch('10345')")
  end
end
