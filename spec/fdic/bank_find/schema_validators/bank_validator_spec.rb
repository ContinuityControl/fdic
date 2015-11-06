require 'spec_helper'

describe FDIC::BankFind::SchemaValidators::BankValidator do
  describe '#schema_valid?' do
    let(:client_instance_double) { double("Client") }
    let(:valid_response_body) {
      {"d" => {
        "results" => [
          {
            "__metadata" => {
              "uri" => "http://odata.fdic.gov:80/v1/financial-institution/Bank('12174')",
              "type" => "financial-institutionModel.Bank"
            },
            "id" => "12174",
            "zip" => "06787",
            "certNumber" => "18258",
            "legalName" => "Thomaston Savings Bank",
            "address" => "203 MAIN STREET",
            "activeFlag" => "Y",
            "state" => "CT",
            "officeCount" => nil,
            "effectiveDate" => nil,
            "city" => "THOMASTON"
          }
        ],
        "__count" => "2",
        "__next" => "some long url" }
      }
    }
    let(:bank_schema_validator) { FDIC::BankFind::SchemaValidators::BankValidator.new }

    before :each do
      allow(FDIC::BankFind::Client).to receive(:new) { client_instance_double }
    end

    context 'valid response' do
      before :each do
        allow(client_instance_double).to receive(:find_bank) { valid_response_body }
      end
      it "returns true" do
        expect(bank_schema_validator.schema_valid?).to be_truthy
      end
    end

    context 'invalid response' do
      before :each do
        allow(client_instance_double).to receive(:find_bank) { invalid_response_body }
      end
      context 'given a some other top level key' do
        let(:invalid_response_body) { { "f" => "doesn't matter here" } }
        it "returns false" do
          expect(bank_schema_validator.schema_valid?).to be_falsey
        end
      end
    end
  end
end
