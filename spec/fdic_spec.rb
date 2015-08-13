require 'spec_helper'

describe FDIC do
  it 'has a version number' do
    expect(FDIC::VERSION).not_to be nil
  end

  describe FDIC::BankFind do
    describe '.find_institution' do
      context 'when the certificate_number is invalid' do
        let(:invalid_certificate_number) { 63977 }
        let(:empty_response) {
          {
            'd' => {
              'results' => [],
              '__count' => '0',
              '__next' => "http://odata.fdic.gov:80/financial-institution/Institution?$format=json&$filter=certNumber%20eq%20#{invalid_certificate_number}&$skiptoken=0,0"
            }
          }
        }

        it 'raises a RecordNotFound exception' do
          allow(FDIC::BankFind::Client).to receive(:find_institution).
            with( invalid_certificate_number ).
            and_return( empty_response )

          expect {
            FDIC::BankFind.find_institution(invalid_certificate_number)
          }.to raise_error(FDIC::Exceptions::RecordNotFound)

        end
      end
    end
  end
end
