require 'rails_helper'

describe D11Team, type: :model do
  # This has to be 'team_owner' since 'owner' is used by the shared dependency owner examples
  let(:team_owner) { FactoryGirl.create(:user) }
  let(:co_owner) { FactoryGirl.create(:user) }
  
  before { @d11_team = FactoryGirl.create(:d11_team, owner: team_owner, co_owner: co_owner, name: "Test D11 Team", code: "TDT") }
  
  subject { @d11_team }

  it { is_expected.to respond_to(:owner) }
  it { is_expected.to respond_to(:co_owner) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:dummy) }
  it { is_expected.to respond_to(:club_crest) }

  it { is_expected.to be_valid }

  describe '#owner' do
    subject { @d11_team.owner }
    it { is_expected.to eq team_owner }
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
  
  describe '#dummy' do
    subject { @d11_team.dummy }
    it { is_expected.to eq false }
  end
  
  it_should_behave_like "named scope"
  it_should_behave_like "name ordered"
  it_should_behave_like "team players"
  
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

  context "when dummy is nil" do
    before { @d11_team.dummy = nil }
    it { is_expected.not_to be_valid }
  end

  context "with home_d11_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_match, home_d11_team: owner) }      
    end
  end

  context "with away_d11_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_match, away_d11_team: owner) }      
    end
  end

  context "with player_match_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:player_match_stat, d11_team: owner) }      
    end
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, d11_team: owner) }      
    end
  end

  context "with transfer_listing dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:transfer_listing, d11_team: owner) }      
    end
  end

  context "with d11_team_table_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_table_stat, d11_team: owner) }      
    end
  end

  context "with d11_team_registration dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_registration, d11_team: owner) }      
    end
  end

  context "with d11_team_match_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_match_squad_stat, d11_team: owner) }      
    end
  end

  context "with d11_team_season_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_season_squad_stat, d11_team: owner) }      
    end
  end
    
end

