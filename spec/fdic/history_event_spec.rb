require 'spec_helper'

describe FDIC::HistoryEvent do
  let(:api_result) {
    {"__metadata"=>
     {
       "uri"=>"http://odata.fdic.gov:80/v1/financial-institution/History('43690')",
       "type"=>"financial-institutionModel.History"
     },
     "acqCertClickable"=>nil,
     "certClickable"=>"certClickable",
     "check350HappenedOn211Day"=>false,
     "currentInsuranceCheck"=>nil,
     "currentInsurance"=>"SAIF",
     "certNumber"=>"30856",
     "changeCode"=>"1",
     "changeDesc"=>"HISTORY RECORD INITIATION",
     "city"=>"ANCHORAGE",
     "id"=>"43690",
     "legalName"=>"First Federal Savings and Loan Association",
     "orgEffDate"=>"1955-01-01 00:00:00.0",
     "state"=>"AK",
     "trustPowerCheck"=>nil,
     "trustPower"=>"TRUST POWERS NOT GRANTED",
     "dvstCertClickable"=>nil,
     "eventDescription"=> "Institution established: Original name:First Federal Savings and Loan Association (30856)",
     "instClassCode"=>"SL",
     "instClassDescription"=> "INSURED SAVINGS AND LOAN ASSOCIATIONS                                           ",
     "movedLocationMessage"=>nil,
     "orgAcqCertNum"=>"0",
     "orgAcqCity"=>nil,
     "orgAcqLegalName"=>nil,
     "orgAcqState"=>nil,
     "orgDvstCertNum"=>"0",
     "orgDvstCity"=>nil,
     "orgDvstLegalName"=>nil,
     "orgDvstState"=>nil,
     "orgTypeDescrption"=> "MUTUAL SAVINGS & LOAN                                                           ",
     "prevLegalName"=>"",
     "primaryRegulatoryAgencyCheck"=>nil,
     "primaryRegulatoryAgency"=>"OFFICE OF THRIFT SUPERVISION",
     "uniqAcqCert"=>nil,
     "uniqCert"=>"30856",
     "uniqDvstCert"=>nil,
    }
  }

  let(:history_event) { FDIC::HistoryEvent.new(api_result) }

  it 'parses data out correctly' do
    expect(history_event.fdic_id).to eq('43690')
    expect(history_event.legal_name).to eq('First Federal Savings and Loan Association')
    expect(history_event.certificate_number).to eq('30856')
    expect(history_event.city).to eq('ANCHORAGE')
    expect(history_event.state).to eq('AK')
    expect(history_event.effective_date).to eq(Date.new(1955, 1, 1))
    expect(history_event.uri).to eq("http://odata.fdic.gov:80/v1/financial-institution/History('43690')")
  end

  context 'when the legal name has extra whitespace' do
    let(:api_result) {
      { 'legalName' => '    1st Bank     ' }
    }
    it 'strips it' do
      expect(history_event.legal_name).to eq('1st Bank')
    end
  end
end
