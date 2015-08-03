require 'spec_helper'

describe FDIC::Institution do
  let(:api_result) {
    {"__metadata"=>
     {"uri"=> "http://odata.fdic.gov:80/v1/financial-institution/Institution('11183')",
      "type"=>"financial-institutionModel.Institution"
     },
     "changeCodes"=>"810,0,0,0,0",
     "establishedDate"=>"1884-01-01 00:00:00.0",
     "certNumber"=>"17145",
     "asOfDate"=>"2015-07-23 00:00:00.0",
     "acqName"=>nil,
     "forOffCnt"=>"0.0",
     "instFinLegalName"=>"Heritage Bank",
     "insuredDate"=>"1952-09-24 00:00:00.0",
     "city"=>"Wood River",
     "acqCert"=>"17145",
     "instClassCode"=>"NM",
     "highRegulatoryHolder"=>"1055089.0",
     "domOffCnt"=>"20",
     "legalName"=>"Heritage Bank",
     "ultCertState"=>"NE",
     "netIncome"=>"2571.0",
     "ultCertName"=> "Heritage Bank              ",
     "ultCertNum"=>"17145",
     "totalDeposits"=>"459705.0",
     "status"=>nil,
     "bankEquityCapital"=>"91419.0",
     "FACodeText"=>"Federal Deposit Insurance Corporation",
     "fedReserveID"=>"666554",
     "insuredFrmDt"=>"1952-09-24 00:00:00.0",
     "returnOnEquity"=>"11.35",
     "county"=>"Hall",
     "domesticDeposits"=>"479999.0",
     "active"=>"1.0",
     "ultCertCity"=>"Wood River",
     "charterNumber"=>"0",
     "FACode"=>"FDIC",
     "insuredToDt"=>"9999-12-31 00:00:00.0",
     "state"=>"NE",
     "quarterlyReturnOnEquity"=>"11.35",
     "preTaxReturnOnAssets"=>"1.71",
     "id"=>"11183",
     "returnOnAssets"=>"1.68",
     "inactive"=>"0.0",
     "uniNum"=>"11183",
     "docketNumber"=>"0",
     "webSite"=>"www.bankonheritage.com",
     "activeFlag"=>"Y",
     "reportDate"=>"2015-03-31 00:00:00.0",
     "changeDesc"=>nil,
     "zip"=>"68883",
     "inActiveAsofDt"=>"9999-12-31 00:00:00.0",
     "changeCode"=>"810",
     "othAreaOffCnt"=>"0",
     "bankClassDesc"=>"Non-member of the Federal Reserve System",
     "ncuaID"=>"0",
     "quarterlyNetIncome"=>"2571.0",
     "quarterlyPreTaxReturnOnAssets"=>"1.71",
     "address"=>"110 E 9th Street",
     "totalAssets"=>"617581.0",
     "holdingCompany"=>"Heritage Group, Inc.",
     "officeCount"=>"20",
     "prevLegalName"=>"",
     "bankClass"=>"NM",
     "quarterlyReturnOnAssets"=>"1.68"
    }
  }

  let(:institution) { FDIC::Institution.new(api_result) }

  it 'parses data out correctly' do
    expect(institution.fdic_id).to eq('11183')
    expect(institution.legal_name).to eq('Heritage Bank')
    expect(institution.certificate_number).to eq('17145')
    expect(institution.supervising_authority).to eq('Federal Deposit Insurance Corporation')
    expect(institution.supervising_authority_code).to eq('FDIC')


    expect(institution).to be_active
    expect(institution.inactive_as_of_date).to eq(Date.new(9999, 12, 31))

    expect(institution.address).to eq('110 E 9th Street')
    expect(institution.city).to eq('Wood River')
    expect(institution.county).to eq('Hall')
    expect(institution.state).to eq('NE')
    expect(institution.zip).to eq('68883')
    expect(institution.web_site).to eq("www.bankonheritage.com")

    expect(institution.insured_date).to eq(Date.new(1952, 9, 24))
    expect(institution.insured_from_date).to eq(Date.new(1952, 9, 24))
    expect(institution.insured_to_date).to eq(Date.new(9999, 12, 31))
    expect(institution.established_date).to eq(Date.new(1884, 1, 1))
    expect(institution.as_of_date).to eq(Date.new(2015, 7, 23))
    expect(institution.report_date).to eq(Date.new(2015, 3, 31))

    expect(institution.office_count).to eq(20)

    expect(institution.total_assets_in_thousands).to eq(617581.0)
    expect(institution.total_deposits_in_thousands).to eq(459705.0)
    expect(institution.domestic_deposits_in_thousands).to eq(479999.0)
    expect(institution.bank_equity_capital_in_thousands).to eq(91419.0)

    expect(institution.uri).to eq("http://odata.fdic.gov:80/v1/financial-institution/Institution('11183')")
  end

  context 'when the legal name has extra whitespace' do
    let(:api_result) {
      { 'legalName' => '    1st Bank     ' }
    }
    it 'strips it' do
      expect(institution.legal_name).to eq('1st Bank')
    end
  end

  context 'when activeFlag is Y' do
    let(:api_result) {
      { 'activeFlag' => 'Y' }
    }
    it 'strips it' do
      expect(institution).to be_active
    end
  end
end
