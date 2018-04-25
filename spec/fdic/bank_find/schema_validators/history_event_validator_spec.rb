require 'spec_helper'

describe FDIC::BankFind::SchemaValidators::HistoryEventValidator do
  describe '#schema_valid?' do
    let(:client_instance_double) { double("Client") }
    let(:valid_response_body) {
      {
        "d" => {
          "results" => [
            {
              "__metadata" => {
                "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/History('12174')", "type" => "financial-institutionModel.History"
              }, "certNumber" => "18258", "orgDvstLegalName" => nil, "primaryRegulatoryAgencyCheck" => nil, "certClickable" => "certClickable", "state" => "CT", "acqCertClickable" => nil, "primaryRegulatoryAgency" => "FEDERAL DEPOSIT INSURANCE CORPORATION", "currentInsurance" => "BIF", "city" => "THOMASTON", "id" => "12174", "instClassCode" => "SI", "instClassDescription" => "FDIC SUPERVISED SAVINGS BANK                                                    ", "currentInsuranceCheck" => nil, "orgDvstCertNum" => "0", "orgTypeDescrption" => "MUTUAL SAVINGS BANK                                                             ", "changeDesc" => "HISTORY RECORD INITIATION", "uniqDvstCert" => nil, "orgDvstCity" => nil, "orgAcqLegalName" => nil, "dvstCertClickable" => nil, "legalName" => "Thomaston Savings Bank", "changeCode" => "1", "check350HappenedOn211Day" => false, "uniqCert" => "18258", "orgAcqCertNum" => "0", "orgDvstState" => nil, "eventDescription" => "Institution established=> Original name=>Thomaston Savings Bank (18258)", "movedLocationMessage" => nil, "orgAcqState" => nil, "trustPowerCheck" => nil, "orgEffDate" => "1874-10-01 00=>00=>00.0", "prevLegalName" => "", "orgAcqCity" => nil, "uniqAcqCert" => nil, "trustPower" => "TRUST POWERS NOT GRANTED"
            }
          ], "__count" => "0", "__next" => "http=>//odata.fdic.gov=>80/v1/financial-institution/History?$format=json&$filter=legalName%20eq%20%27THOMASTON%20SAVINGS%20BANK%27%20and%20certNumber%20eq%2018258&$skiptoken=0,0"
        }
      }
    }
    let(:history_event_validator) { FDIC::BankFind::SchemaValidators::HistoryEventValidator.new }

    before :each do
      allow(FDIC::BankFind::Client).to receive(:new) { client_instance_double }
    end

    context 'valid response' do
      let(:response_double) { double(parsed_response: valid_response_body) }

      before :each do
        allow(client_instance_double).to receive(:find_history_events) { response_double }
      end

      it "returns true" do
        expect(history_event_validator.schema_valid?).to be_truthy
      end
    end

    context 'invalid response' do
      let(:response_double) { double(parsed_response: invalid_response_body) }

      before :each do
        allow(client_instance_double).to receive(:find_history_events) { response_double }
      end

      context 'given a some other top level key' do
        let(:invalid_response_body) { { "f" => "doesn't matter here" } }

        it "returns false" do
          expect(history_event_validator.schema_valid?).to be_falsey
        end
      end
    end
  end
end
