require 'spec_helper'

describe FDIC::BankFind::SchemaValidators::InstitutionValidator do
  describe '#schema_valid?' do
    let(:client_instance_double) { double("Client") }
    let(:valid_response_body) {
      {
        "d" => {
          "results" => [
            {
              "__metadata" => {
                "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Institution('12174')",
                "type" => "financial-institutionModel.Institution"
              },
              "changeCodes" => "510, 412, 0, 0, 0",
              "establishedDate" => "1874-10-01 00=>00=>00.0",
              "certNumber" => "18258",
              "asOfDate" => "2015-11-05 00=>00=>00.0",
              "acqName" => "",
              "forOffCnt" => "0.0",
              "instFinLegalName" => "Thomaston Savings Bank",
              "insuredDate" => "1960-07-01 00=>00=>00.0",
              "city" => "Thomaston",
              "acqCert" => "0",
              "instClassCode" => "SI",
              "highRegulatoryHolder" => "0.0",
              "domOffCnt" => "10",
              "legalName" => "Thomaston Savings Bank",
              "ultCertState" => "CT",
              "netIncome" => "1942.0",
              "ultCertName" => "Thomaston Savings Bank",
              "ultCertNum" => "18258",
              "totalDeposits" => "716465.0",
              "status" => nil,
              "bankEquityCapital" => "104233.0",
              "FACodeText" => "Federal Deposit Insurance Corporation",
              "fedReserveID" => "120609",
              "insuredFrmDt" => "1960-07-01 00=>00=>00.0",
              "returnOnEquity" => "3.75",
              "county" => "Litchfield",
              "domesticDeposits" => "716465.0",
              "active" => "1.0",
              "ultCertCity" => "Thomaston",
              "charterNumber" => "0",
              "FACode" => "FDIC",
              "insuredToDt" => "9999-12-31 00=>00=>00.0",
              "state" => "CT",
              "quarterlyReturnOnEquity" => "3.92",
              "preTaxReturnOnAssets" => "0.58",
              "id" => "12174",
              "returnOnAssets" => "0.47",
              "inactive" => "0.0",
              "uniNum" => "12174",
              "docketNumber" => "10783",
              "webSite" => "www.thomastonsavingsbank.com",
              "activeFlag" => "Y",
              "reportDate" => "2015-06-30 00=>00=>00.0",
              "changeDesc" => nil,
              "zip" => "06787",
              "inActiveAsofDt" => "9999-12-31 00=>00=>00.0",
              "changeCode" => "510",
              "othAreaOffCnt" => "0",
              "bankClassDesc" => "FDIC-Regulated Savings Bank",
              "ncuaID" => "0",
              "quarterlyNetIncome" => "1018.0",
              "quarterlyPreTaxReturnOnAssets" => "0.6",
              "address" => "203 Main Street",
              "totalAssets" => "847230.0",
              "holdingCompany" => nil,
              "officeCount" => "10",
              "prevLegalName" => "",
              "bankClass" => "SB",
              "quarterlyReturnOnAssets" => "0.48"
            }
          ],
          "__count" => "0",
          "__next" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Institution?$format=json&$filter=certNumber%20eq%2018258&$skiptoken=0, 0"
        }
      }
    }
    let(:institution_validator) { FDIC::BankFind::SchemaValidators::InstitutionValidator.new }

    before :each do
      allow(FDIC::BankFind::Client).to receive(:new) { client_instance_double }
    end

    context 'valid response' do
      before :each do
        allow(client_instance_double).to receive(:find_institution) { valid_response_body }
      end
      it "returns true" do
        expect(institution_validator.schema_valid?).to be_truthy
      end
    end

    context 'invalid response' do
      before :each do
        allow(client_instance_double).to receive(:find_institution) { invalid_response_body }
      end
      context 'given a some other top level key' do
        let(:invalid_response_body) { { "f" => "doesn't matter here" } }
        it "returns false" do
          expect(institution_validator.schema_valid?).to be_falsey
        end
      end
    end
  end
end
