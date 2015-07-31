require 'spec_helper'

describe FDIC::Client do
  it "escapes single-quotes by doubling them up. ' -> ''" do
    expect(FDIC::Client).to receive(:get) do |action, query|
      expect(query[:query]['$filter']).to include("PEOPLE''S UNITED")
    end

    FDIC::Client.new.find_bank("People's United")
  end
end
