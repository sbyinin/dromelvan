require 'rails_helper'

describe PremierLeague, type: :model do
  
  let(:season) { FactoryGirl.create(:season, name: "2000-2001") }
  
  before { @premier_league = FactoryGirl.create(:premier_league, season: season, name: "Barclays Premier League") }
  
  subject { @premier_league }
  
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:name) }  
  
  it { is_expected.to be_valid }
  
  describe '#season' do
    subject { @premier_league.season }
    it { is_expected.to eq season }
  end

  describe '#name' do
    subject { @premier_league.name }
    it { is_expected.to eq "Barclays Premier League" }
  end
  
  it_should_behave_like "season unique named"
  
  context "when season is nil" do
    before { @premier_league.season = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when name is blank" do
    before { @premier_league.name = "" }
    it { is_expected.not_to be_valid }
  end
  
  describe '.current' do
    before { PremierLeague.destroy_all }
    before { Season.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, date: Date.today) }
    let!(:premier_league1) { FactoryGirl.create(:premier_league, season: season1) }
    let!(:premier_league2) { FactoryGirl.create(:premier_league, season: season2) }
    
    specify { expect(PremierLeague.current).to eq premier_league2 }
  end
  
end
