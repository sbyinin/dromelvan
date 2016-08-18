require 'rails_helper'

describe Season, type: :model do
  before { @season = Season.new(name: "2012-2013", status: 2, date: Date.today, legacy: true) }
  
  subject { @season }
  
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:pending?) }
  it { is_expected.to respond_to(:active?) }
  it { is_expected.to respond_to(:finished?) }    
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:legacy) }

  it { is_expected.to be_valid }

  describe '#name' do
    subject { @season.name }
    it { is_expected.to eq "2012-2013" }
  end

  describe '#status' do
    subject { @season.status }
    it { is_expected.to eq :finished.to_s }
  end

  describe '#date' do
    subject { @season.date }
    it { is_expected.to eq Date.today }
  end

  describe '#legacy' do
    subject { @season.legacy }
    it { is_expected.to eq true }
  end

  describe '.current' do
    before { Season.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, date: Date.today) }
    
    specify { expect(Season.current).to eq season2 }
  end

  describe '.winner & .runners_up' do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
    let!(:player1) { FactoryGirl.create(:player) }
    let!(:player2) { FactoryGirl.create(:player) }
    let!(:player3) { FactoryGirl.create(:player) }    
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player1, match: match, rating: 800) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player2, match: match, rating: 700) }
    let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player3, match: match, rating: 600) }
    #let!(:player_season_stat1) { FactoryGirl.create(:player_season_stat, season: season, player: player_match_stat1.player) }
    #let!(:player_season_stat2) { FactoryGirl.create(:player_season_stat, season: season, player: player_match_stat2.player) }
    #let!(:player_season_stat3) { FactoryGirl.create(:player_season_stat, season: season, player: player_match_stat3.player) }
    
    before do
      player1.season_stat(season).save
      player2.season_stat(season).save
      player3.season_stat(season).save              
      PlayerSeasonStat.update_rankings(season)
    end
    
    specify { expect(season.winner).to eq player1.season_stat(season) }
    specify { expect(season.runners_up).to eq [ player2.season_stat(season), player3.season_stat(season) ] }    
  end
  
  it_should_behave_like "named scope"
  
  context "when name is nil" do
    before { @season.name = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when name is blank" do
    before { @season.name = "" }
    it { is_expected.not_to be_valid }
  end
    
  context "when status is nil" do
    before { @season.status = nil }
    it { is_expected.not_to be_valid }
  end

  describe '#pending?' do
    subject { @season.pending? }
    it { is_expected.to eq false }
  end

  describe '#active?' do
    subject { @season.active? }
    it { is_expected.to eq false }
  end
    
  describe '#finished?' do
    subject { @season.finished? }
    it { is_expected.to eq true }
  end
  
  context "when legacy is nil" do
    before { @season.legacy = nil }
    it { is_expected.not_to be_valid }
  end

  context "with premier_league dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:premier_league, season: owner) }      
    end
  end

  context "with d11_league dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:d11_league, season: owner) }      
    end
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, season: owner) }
      
      before do
        owner.player_season_stats.destroy_all
        owner.player_season_infos.where("player_season_infos.id != ?", dependent.id).destroy_all
      end
    end
  end

  context "with player_season_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:player_season_stat, season: owner) }      
    end
    
    before do
      owner.player_season_infos.destroy_all
      owner.player_season_stats.where("player_season_stats.id != ?", dependent.id).destroy_all
    end    
  end

  context "with transfer_window dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:transfer_window, season: owner) }      
    end
  end

  context "with team_registration dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:team_registration, season: owner) }      
    end
  end

  context "with d11_team_registration dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:d11_team_registration, season: owner) }      
    end
  end

  context "with team_season_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:team_season_squad_stat, season: owner) }      
    end
  end

  context "with d11_team_season_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:d11_team_season_squad_stat, season: owner) }      
    end
  end

  describe "default scope order" do
    before { Season.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, date: Date.today) }
    
    specify { expect(Season.all).to eq [ season2, season1 ] }
  end
  
end
