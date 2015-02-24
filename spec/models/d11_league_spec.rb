require 'rails_helper'

describe D11League, type: :model do
  
  let(:season) { FactoryGirl.create(:season, name: "2000-2001") }
  
  before { @d11_league = FactoryGirl.create(:d11_league, season: season, name: "Drömelvan") }
  
  subject { @d11_league }
  
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:name) }  
  
  it { is_expected.to be_valid }
  
  describe '#season' do
    subject { @d11_league.season }
    it { is_expected.to eq season }
  end

  describe '#name' do
    subject { @d11_league.name }
    it { is_expected.to eq "Drömelvan" }
  end
  
  describe '.current' do
    before { D11League.destroy_all }
    before { Season.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, date: Date.today) }
    let!(:d11_league1) { FactoryGirl.create(:d11_league, season: season1) }
    let!(:d11_league2) { FactoryGirl.create(:d11_league, season: season2) }
    
    specify { expect(D11League.current).to eq d11_league2 }
  end

  describe '.winner & .runners_up' do
    let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league) }    
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_league: d11_league, d11_match_day: d11_match_day, home_matches_won: 3) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_league: d11_league, d11_match_day: d11_match_day, home_matches_won: 2) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, d11_league: d11_league, d11_match_day: d11_match_day, away_matches_won: 1) }
        
    before do
      D11TeamTableStat.update_rankings(d11_match_day)
    end
    
    specify { expect(d11_league.winner).to eq d11_team_table_stat1 }
    specify { expect(d11_league.runners_up).to eq [ d11_team_table_stat2, d11_team_table_stat3 ] }    
  end
  
  it_should_behave_like "season unique named"
   
  context "when season is nil" do
    before { @d11_league.season = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when name is blank" do
    before { @d11_league.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "with d11_match_day dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_league) }
      let!(:dependent) { FactoryGirl.create(:d11_match_day, d11_league: owner) }      
    end
  end

  context "with d11_team_table_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_league) }
      let!(:dependent) { FactoryGirl.create(:d11_team_table_stat, d11_league: owner) }      
    end
  end

end
