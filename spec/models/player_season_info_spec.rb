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

end
