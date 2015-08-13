require 'spec_helper'

describe FDIC::BankFind::Client do
  it "escapes single-quotes by doubling them up. ' -> ''" do
    expect(FDIC::BankFind::Client).to receive(:get) do |action, query|
      expect(query[:query]['$filter']).to include("PEOPLE''S UNITED")
    end

    FDIC::BankFind::Client.new.find_bank("People's United")
  end
end
