require 'rails_helper'

describe PlayerSeasonStat, type: :model do  
  let(:player) { FactoryGirl.create(:player) }
  let(:season) { FactoryGirl.create(:season) }
  
  before { @player_season_stat = FactoryGirl.create(:player_season_stat, player: player, season: season) }
  
  subject { @player_season_stat }

  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:ranking) }

  it { is_expected.to be_valid }

  describe '#player' do
    subject { @player_season_stat.player }
    it { is_expected.to eq player }
  end

  describe '#season' do
    subject { @player_season_stat.season }
    it { is_expected.to eq season }
  end

  describe '#ranking' do
    subject { @player_season_stat.ranking }
    it { is_expected.to eq 0 }
  end
  
  it_should_behave_like "player stats summary"

  context "when player is nil" do
    before { @player_season_stat.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match is nil" do
    before { @player_season_stat.season = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when ranking is nil" do
    before { @player_season_stat.ranking = nil }
    it { is_expected.not_to be_valid }
  end

  context "when ranking is invalid" do
    before { @player_season_stat.ranking = -1 }
    it { is_expected.not_to be_valid }
  end
  
end
