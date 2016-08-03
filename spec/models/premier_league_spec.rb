require 'rails_helper'

describe PremierLeague, type: :model do
  
  let(:season) { FactoryGirl.create(:season, name: "2000-2001") }
  
  before { @premier_league = FactoryGirl.create(:premier_league, season: season, name: "Barclays Premier League") }
  
  subject { @premier_league }
  
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:current_match_day) }
  
  it { is_expected.to be_valid }
  
  describe '#season' do
    subject { @premier_league.season }
    it { is_expected.to eq season }
  end

  describe '#name' do
    subject { @premier_league.name }
    it { is_expected.to eq "Barclays Premier League" }
  end
  
  describe '#current_match_day' do
    before { MatchDay.destroy_all }
    
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }    
    let!(:match_day1) { FactoryGirl.create(:match_day, date: Date.today - 1.day, premier_league: premier_league) }
    let!(:match_day2) { FactoryGirl.create(:match_day, date: Date.today, premier_league: premier_league) }
    let!(:match_day3) { FactoryGirl.create(:match_day, date: Date.today + 1.day, premier_league: premier_league) }
    
    specify { expect(premier_league.current_match_day).to eq match_day2 }
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

  describe '.winner & .runners_up' do
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }    
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, premier_league: premier_league, match_day: match_day, home_matches_won: 3) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, premier_league: premier_league, match_day: match_day, home_matches_won: 2) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, premier_league: premier_league, match_day: match_day, away_matches_won: 1) }
        
    before do
      TeamTableStat.update_rankings(match_day)
    end
    
    specify { expect(premier_league.winner).to eq team_table_stat1 }
    specify { expect(premier_league.runners_up).to eq [ team_table_stat2, team_table_stat3 ] }    
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

  context "with match_day dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:premier_league) }
      let!(:dependent) { FactoryGirl.create(:match_day, premier_league: owner) }      
    end
  end

  context "with team_table_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:premier_league) }
      let!(:dependent) { FactoryGirl.create(:team_table_stat, premier_league: owner) }      
    end
  end
    
end
