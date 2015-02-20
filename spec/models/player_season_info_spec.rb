require 'rails_helper'

describe PlayerSeasonInfo, type: :model do

  let(:player) { FactoryGirl.create(:player) }
  let(:season) { FactoryGirl.create(:season) }
  let(:team) { FactoryGirl.create(:team) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }
  let(:position) { FactoryGirl.create(:position) }

  before { @player_season_info = FactoryGirl.create(:player_season_info, player: player, season: season, team: team, d11_team: d11_team, position: position, value: 15) }
  
  subject { @player_season_info }

  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:team) }
  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:value) }
  
  it { is_expected.to be_valid }

  describe '#player' do
    subject { @player_season_info.player }
    it { is_expected.to eq player }
  end

  describe '#season' do
    subject { @player_season_info.season }
    it { is_expected.to eq season }
  end

  describe '#team' do
    subject { @player_season_info.team }
    it { is_expected.to eq team }
  end

  describe '#d11_team' do
    subject { @player_season_info.d11_team }
    it { is_expected.to eq d11_team }
  end

  describe '#position' do
    subject { @player_season_info.position }
    it { is_expected.to eq position }
  end

  describe '#value' do
    subject { @player_season_info.value }
    it { is_expected.to eq 15 }
  end

  describe '.by_player' do
    before { PlayerSeasonInfo.destroy_all }
    
    let!(:player1) { FactoryGirl.create(:player) }
    let!(:player2) { FactoryGirl.create(:player) }
    let!(:player_season_info1) { FactoryGirl.create(:player_season_info, player: player1) }
    let!(:player_season_info2) { FactoryGirl.create(:player_season_info, player: player2) } 
   
    specify { expect(PlayerSeasonInfo.by_player(player1)).to eq [ player_season_info1 ] }
    specify { expect(PlayerSeasonInfo.by_player(player2)).to eq [ player_season_info2 ] }    
  end

  describe '.by_season' do
    before { PlayerSeasonInfo.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season) }
    let!(:season2) { FactoryGirl.create(:season) }
    let!(:player_season_info1) { FactoryGirl.create(:player_season_info, season: season1) }
    let!(:player_season_info2) { FactoryGirl.create(:player_season_info, season: season2) } 
   
    specify { expect(PlayerSeasonInfo.by_season(season1)).to eq [ player_season_info1 ] }
    specify { expect(PlayerSeasonInfo.by_season(season2)).to eq [ player_season_info2 ] }    
  end

  describe '.current' do
    before { PlayerSeasonInfo.destroy_all }

    let!(:season) { FactoryGirl.create(:season) }
    let!(:player) { FactoryGirl.create(:player) }
    
    context "when current exists" do
      let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: season) }
      
      specify { expect(PlayerSeasonInfo.current(player)).to eq player_season_info }
    end
    
    context "when current doesn't exist" do
      context "when previous exists" do
        let!(:season2) { FactoryGirl.create(:season, date: season.date - 1.day) }
        let!(:player_season_info2) { FactoryGirl.create(:player_season_info, player: player, season: season2) }
        let!(:season3) { FactoryGirl.create(:season, date: season.date - 2.day) }
        let!(:player_season_info3) { FactoryGirl.create(:player_season_info, player: player, season: season3) }                
        let(:player_season_info) { PlayerSeasonInfo.current(player) }
        
        specify { expect(player_season_info).not_to be_nil }
        specify { expect(player_season_info.player).to eq player }
        specify { expect(player_season_info.season).to eq season }
        # It should not have the default position.
        specify { expect(player_season_info.position).to eq player_season_info2.position }        
        specify { expect(player_season_info.position).not_to eq PlayerSeasonInfo.new.position }        
        specify { expect(player_season_info.position).not_to eq player_season_info3.position }        
      end
      
      context "when previous does not exist" do
        let(:player_season_info) { PlayerSeasonInfo.current(player) }
        
        specify { expect(player_season_info).not_to be_nil }
        specify { expect(player_season_info.player).to eq player }
        specify { expect(player_season_info.season).to eq season }
        # It should have the default position.
        specify { expect(player_season_info.position).to eq PlayerSeasonInfo.new.position }
      end      
    end
  end
 
  describe '.by_player_and_season' do
    before { PlayerSeasonInfo.destroy_all }

    let!(:season) { FactoryGirl.create(:season) }
    let!(:player) { FactoryGirl.create(:player) }
    
    context "when not missing" do
      let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: season) }
      
      specify { expect(PlayerSeasonInfo.by_player_and_season(player, season)).to eq player_season_info }
    end

    context "when missing" do
      context "when previous not missing" do
        let!(:season2) { FactoryGirl.create(:season, date: season.date - 1.day) }
        let!(:player_season_info2) { FactoryGirl.create(:player_season_info, player: player, season: season2) }
        let!(:season3) { FactoryGirl.create(:season, date: season.date - 2.day) }
        let!(:player_season_info3) { FactoryGirl.create(:player_season_info, player: player, season: season3) }                
        let(:player_season_info) { PlayerSeasonInfo.current(player) }
        
        specify { expect(player_season_info).not_to be_nil }
        specify { expect(player_season_info.player).to eq player }
        specify { expect(player_season_info.season).to eq season }
        # It should not have the default position.
        specify { expect(player_season_info.position).to eq player_season_info2.position }        
        specify { expect(player_season_info.position).not_to eq PlayerSeasonInfo.new.position }        
        specify { expect(player_season_info.position).not_to eq player_season_info3.position }        
      end

      context "when previous missing" do
        let(:player_season_info) { PlayerSeasonInfo.by_player_and_season(player, season) }
        
        specify { expect(player_season_info).not_to be_nil }
        specify { expect(player_season_info.player).to eq player }
        specify { expect(player_season_info.season).to eq season }
        # It should have the default position.
        specify { expect(player_season_info.position).to eq PlayerSeasonInfo.new.position }
      end      
    end

  end

  context "when player is nil" do
    before { @player_season_info.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when season is nil" do
    before { @player_season_info.season = nil }
    it { is_expected.not_to be_valid }
  end

  context "when team is nil" do
    before { @player_season_info.team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_team is nil" do
    before { @player_season_info.d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when position is nil" do
    before { @player_season_info.position = nil }
    it { is_expected.not_to be_valid }
  end

  context "when value is nil" do
    before { @player_season_info.value = nil }
    it { is_expected.not_to be_valid }
  end

  context "when value is invalid" do
    before { @player_season_info.value = 1000 }
    it { is_expected.not_to be_valid }
  end

  context "when player is not unique in season scope" do
    let(:player_season_info) { FactoryGirl.create(:player_season_info) }
    
    before do
      # Can't do this in FactoryGirl.create since a validation error will be thrown there.
      player_season_info.player = @player_season_info.player
      player_season_info.season = @player_season_info.season
    end
    
    subject { player_season_info }    
    it { is_expected.not_to be_valid }
  end

  describe "default scope order" do
    before { PlayerSeasonInfo.destroy_all }
    
    let!(:player) { FactoryGirl.create(:player) }
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 2.day) }
    let!(:season2) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:player_season_info1) { FactoryGirl.create(:player_season_info, player: player, season: season1) }
    let!(:player_season_info2) { FactoryGirl.create(:player_season_info, player: player, season: season2) } 
   
    specify { expect(PlayerSeasonInfo.all).to eq [ player_season_info2, player_season_info1 ] }
  end 
end
