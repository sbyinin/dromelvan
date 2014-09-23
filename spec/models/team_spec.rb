require 'rails_helper'

describe Team, type: :model do
  
  let(:stadium) { FactoryGirl.create(:stadium) }
  
  before { @team = FactoryGirl.create(:team, stadium: stadium, whoscored_id: 1, name: "Test Team", code: "TTM", nickname: "Test Nickname", established: 1900, motto: "Test Motto", colour: "#FFFFFF") }
  
  subject { @team }

  it { is_expected.to respond_to(:stadium) }
  it { is_expected.to respond_to(:whoscored_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:nickname) }
  it { is_expected.to respond_to(:established) }
  it { is_expected.to respond_to(:motto) }
  it { is_expected.to respond_to(:colour) }
  it { is_expected.to respond_to(:club_crest) }

  it { is_expected.to be_valid }

  describe '#stadium' do
    subject { @team.stadium }
    it { is_expected.to eq stadium }
  end

  describe '#whoscored_id' do
    subject { @team.whoscored_id }
    it { is_expected.to eq 1 }
  end

  describe '#name' do
    subject { @team.name }
    it { is_expected.to eq "Test Team" }
  end

  describe '#code' do
    subject { @team.code }
    it { is_expected.to eq "TTM" }
  end

  describe '#nickname' do
    subject { @team.nickname }
    it { is_expected.to eq "Test Nickname" }
  end

  describe '#establised' do
    subject { @team.established }
    it { is_expected.to eq 1900 }
  end

  describe '#motto' do
    subject { @team.motto }
    it { is_expected.to eq "Test Motto" }
  end

  describe '#colour' do
    subject { @team.colour }
    it { is_expected.to eq "#FFFFFF" }
  end

  it_should_behave_like "named scope"
  it_should_behave_like "name ordered"
  
  context "when nickname is blank" do
    before { @team.nickname = "" }
    it { is_expected.to be_valid }
  end

  context "when stadium is nil" do
    before { @team.stadium = nil }
    it { is_expected.not_to be_valid }
  end

  context "when whoscored_id is nil" do
    before { @team.whoscored_id = nil }
    it { is_expected.not_to be_valid }
  end

  context "when name is blank" do
    before { @team.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "when code is blank" do
    before { @team.code = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when established is nil" do
    before { @team.established = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when motto is nil" do
    before { @team.whoscored_id = nil }
    it { is_expected.not_to be_valid }
  end

  context "when colour is nil" do
    before { @team.colour = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when colour is invalid" do
    before { @team.colour = "123123" }
    it { is_expected.not_to be_valid }
  end

  context "with home_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:match, home_team: owner) }      
    end
  end

  context "with away_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:match, away_team: owner) }      
    end
  end

  context "with goal dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:goal, team: owner) }      
    end
  end

  context "with card dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:card, team: owner) }      
    end
  end

  context "with substitution dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:substitution, team: owner) }      
    end
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, team: owner) }      
    end
  end
  
end
