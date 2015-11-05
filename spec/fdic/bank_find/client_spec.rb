require 'spec_helper'

describe FDIC::BankFind::Client do
  describe '#find_bank' do
    it "escapes single-quotes by doubling them up. ' -> ''" do
      safe_response = double("HTTParty::Response", code: 200)
      expect(FDIC::BankFind::Client).to receive(:get) do |action, query|
        expect(query[:query]['$filter']).to include("PEOPLE''S UNITED")
      end.and_return(safe_response)

      FDIC::BankFind::Client.new.find_bank("People's United")
    end

    context 'when the FDIC is having struggles' do
      it 'raises an exception' do
        response = double("HTTParty::Response", code: 500)
        allow(FDIC::BankFind::Client).to receive(:get).and_return(response)

        expect {
          FDIC::BankFind::Client.new.find_bank("foo")
        }.to raise_error(FDIC::Exceptions::ServerError)
      end
    end
  end
end
