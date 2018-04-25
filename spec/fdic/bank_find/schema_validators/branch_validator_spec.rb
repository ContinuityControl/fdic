require 'spec_helper'

describe FDIC::BankFind::SchemaValidators::BranchValidator do
  describe '#schema_valid?' do
    let(:client_instance_double) { double("Client") }
    let(:valid_response_body) {
      { "d" => {
        "results" => [
          {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('531679')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6010.0", "establishedDate" => "2012-06-04 00=>00=>00.0", "branchNum" => "9", "state" => "CT", "city" => "Bristol", "id" => "531679", "fiUninum" => "12174", "address" => "40 Middle St", "county" => "Hartford", "branchName" => "Middle Street Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('244561')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6751.0", "establishedDate" => "1995-06-07 00=>00=>00.0", "branchNum" => "4", "state" => "CT", "city" => "Bethlehem", "id" => "244561", "fiUninum" => "12174", "address" => "73 Main Street South", "county" => "Litchfield", "branchName" => "Bethlehem Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('244560')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6791.0", "establishedDate" => "1975-03-22 00=>00=>00.0", "branchNum" => "3", "state" => "CT", "city" => "Harwinton", "id" => "244560", "fiUninum" => "12174", "address" => "160 Litchfield Road", "county" => "Litchfield", "branchName" => "Harwinton Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('244558')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6786.0", "establishedDate" => "1961-10-02 00=>00=>00.0", "branchNum" => "1", "state" => "CT", "city" => "Terryville", "id" => "244558", "fiUninum" => "12174", "address" => "203 Main Street", "county" => "Litchfield", "branchName" => "Terryville Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('12174')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6787.0", "establishedDate" => "1874-10-01 00=>00=>00.0", "branchNum" => nil, "state" => "CT", "city" => "Thomaston", "id" => "12174", "fiUninum" => "12174", "address" => "203 Main Street", "county" => "Litchfield", "branchName" => "Thomaston Savings Bank", "acquiredDate" => nil, "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('244562')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6787.0", "establishedDate" => "1998-01-05 00=>00=>00.0", "branchNum" => "5", "state" => "CT", "city" => "Thomaston", "id" => "244562", "fiUninum" => "12174", "address" => "508 South Main Street", "county" => "Litchfield", "branchName" => "South Main Street Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('244559')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6795.0", "establishedDate" => "1951-10-01 00=>00=>00.0", "branchNum" => "2", "state" => "CT", "city" => "Watertown", "id" => "244559", "fiUninum" => "12174", "address" => "565 Main Street", "county" => "Litchfield", "branchName" => "Watertown Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('462795')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6762.0", "establishedDate" => "2007-04-23 00=>00=>00.0", "branchNum" => "7", "state" => "CT", "city" => "Middlebury", "id" => "462795", "fiUninum" => "12174", "address" => "1655 Straits Turnpike", "county" => "New Haven", "branchName" => "Middlebury Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('362618')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6708.0", "establishedDate" => "2001-10-22 00=>00=>00.0", "branchNum" => "6", "state" => "CT", "city" => "Waterbury", "id" => "362618", "fiUninum" => "12174", "address" => "985 Watertown Avenue", "county" => "New Haven", "branchName" => "Waterbury Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }, {
            "__metadata" => {
              "uri" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch('491188')", "type" => "financial-institutionModel.Branch"
            }, "certNumber" => "18258", "zip" => "6708.0", "establishedDate" => "2009-05-13 00=>00=>00.0", "branchNum" => "8", "state" => "CT", "city" => "Waterbury", "id" => "491188", "fiUninum" => "12174", "address" => "824 Highland Avenue", "county" => "New Haven", "branchName" => "Highland Avenue Waterbury Branch", "acquiredDate" => "9999-12-31 00=>00=>00.0", "servTypeCd" => "11"
          }
        ], "__count" => "10", "__next" => "http=>//odata.fdic.gov=>80/v1/financial-institution/Branch?$format=json&$inlinecount=allpages&$filter=certNumber%20eq%2018258&$skiptoken=10,10"
      }
      }
    }
    let(:branch_validator) { FDIC::BankFind::SchemaValidators::BranchValidator.new }

    before :each do
      allow(FDIC::BankFind::Client).to receive(:new) { client_instance_double }
    end

    context 'valid response' do
      let(:response_double) { double(parsed_response: valid_response_body) }

      before :each do
        allow(client_instance_double).to receive(:find_branches) { response_double }
      end

      it "returns true" do
        expect(branch_validator.schema_valid?).to be_truthy
      end
    end

    context 'invalid response' do
      let(:response_double) { double(parsed_response: invalid_response_body) }

      before :each do
        allow(client_instance_double).to receive(:find_branches) { response_double }
      end

      context 'given a some other top level key' do
        let(:invalid_response_body) { { "f" => "doesn't matter here" } }
        it "returns false" do
          expect(branch_validator.schema_valid?).to be_falsey
        end
      end
    end
  end
end
