require 'spec_helper'

describe FDIC::Bank do
  let(:api_result) {
    {
      "__metadata"=> {
        "uri"=>"http://odata.fdic.gov:80/v1/financial-institution/Bank('8950')",
        "type"=>"financial-institutionModel.Bank"
      },
      "id"=>"8950",
      "zip"=>"68970",
      "certNumber"=>"14326",
      "legalName"=>"Peoples-Webster County Bank",
      "address"=>"126 WEST FOURTH STREET",
      "activeFlag"=>"N",
      "state"=>"NE",
      "officeCount"=>nil,
      "effectiveDate"=>nil,
      "city"=>"RED CLOUD"
    }
  }

  let(:bank) { FDIC::Bank.new(api_result) }

  it 'parses data out correctly' do
    expect(bank.fdic_id).to eq('8950')
    expect(bank.legal_name).to eq('Peoples-Webster County Bank')
    expect(bank.certificate_number).to eq('14326')
    expect(bank).to_not be_active
    expect(bank.address).to eq('126 WEST FOURTH STREET')
    expect(bank.city).to eq('RED CLOUD')
    expect(bank.state).to eq('NE')
    expect(bank.zip).to eq('68970')
    expect(bank.office_count).to be_nil
    expect(bank.effective_date).to be_nil
    expect(bank.uri).to eq("http://odata.fdic.gov:80/v1/financial-institution/Bank('8950')")
  end

  context 'when the legal name has extra whitespace' do
    let(:api_result) {
      { 'legalName' => '    1st Bank     ' }
    }
    it 'strips it' do
      expect(bank.legal_name).to eq('1st Bank')
    end
  end

  context 'when activeFlag is Y' do
    let(:api_result) {
      { 'activeFlag' => 'Y' }
    }
    it 'strips it' do
      expect(bank).to be_active
    end
  end
end
