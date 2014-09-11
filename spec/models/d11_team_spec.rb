require 'rails_helper'

describe D11Team, type: :model do
  let(:owner) { FactoryGirl.create(:user) }
  let(:co_owner) { FactoryGirl.create(:user) }
  
  before { @d11_team = FactoryGirl.create(:d11_team, owner: owner, co_owner: co_owner, name: "Test D11 Team", code: "TDT") }
  
  subject { @d11_team }

  it { is_expected.to respond_to(:owner) }
  it { is_expected.to respond_to(:co_owner) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:club_crest) }

  it { is_expected.to be_valid }

  describe '#owner' do
    subject { @d11_team.owner }
    it { is_expected.to eq owner }
  end

  describe '#co_owner' do
    subject { @d11_team.co_owner }
    it { is_expected.to eq co_owner }
  end

  describe '#name' do
    subject { @d11_team.name }
    it { is_expected.to eq "Test D11 Team" }
  end

  describe '#code' do
    subject { @d11_team.code }
    it { is_expected.to eq "TDT" }
  end
  
  it_should_behave_like "named scope"
  it_should_behave_like "name ordered"
  
  context "when co_owner is nil" do
    before { @d11_team.co_owner = nil }
    it { is_expected.to be_valid }
  end

  context "when code is nil" do
    before { @d11_team.code = nil }
    it { is_expected.to be_valid }
  end
  
  context "when owner is nil" do
    before { @d11_team.owner = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when name is blank" do
    before { @d11_team.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "when name is invalid" do
    before { @d11_team.name = "12345678901234567890123456" }
    it { is_expected.not_to be_valid }
  end

  context "when code is invalid" do
    before { @d11_team.code = "1234" }
    it { is_expected.not_to be_valid }
  end
    
end

