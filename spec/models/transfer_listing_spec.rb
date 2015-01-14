require 'rails_helper'

describe TransferListing, type: :model do
  
  let(:transfer_day) { FactoryGirl.create(:transfer_day) }
  let(:player) { FactoryGirl.create(:player) }
  let(:team) { FactoryGirl.create(:team) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }
  let(:position) { FactoryGirl.create(:position) }
  
  before { @transfer_listing = FactoryGirl.create(:transfer_listing, transfer_day: transfer_day, player: player, team: team, d11_team: d11_team, position: position, ranking: 1, new_player: true) }
  
  subject { @transfer_listing }

  it { is_expected.to respond_to(:transfer_day) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:team) }
  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:position) }
  it { is_expected.to respond_to(:ranking) }
  it { is_expected.to respond_to(:new_player) }

  it { is_expected.to be_valid }
  
  describe '#transfer_day' do
    subject { @transfer_listing.transfer_day }
    it { is_expected.to eq transfer_day }
  end
  
  describe '#player' do
    subject { @transfer_listing.player }
    it { is_expected.to eq player }
  end
  
  describe '#team' do
    subject { @transfer_listing.team }
    it { is_expected.to eq team }
  end

  describe '#d11_team' do
    subject { @transfer_listing.d11_team }
    it { is_expected.to eq d11_team }
  end
  
  describe '#position' do
    subject { @transfer_listing.position }
    it { is_expected.to eq position }
  end
  
  describe '#ranking' do
    subject { @transfer_listing.ranking }
    it { is_expected.to eq 1 }
  end
  
  describe '#new_player' do
    subject { @transfer_listing.new_player }
    it { is_expected.to eq true }
  end
  
  it_should_behave_like "player stats summary"
  
  # player_match_stats
  # default scope order
  
  context "when transfer_day is nil" do
    before { @transfer_listing.transfer_day = nil }
    it { is_expected.not_to be_valid }
  end

  context "when player is nil" do
    before { @transfer_listing.player = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when team is nil" do
    before { @transfer_listing.team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_team is nil" do
    before { @transfer_listing.d11_team = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when position is nil" do
    before { @transfer_listing.position = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when ranking is nil" do
    before { @transfer_listing.ranking = nil }
    it { is_expected.not_to be_valid }
  end

  context "when ranking is invalid" do
    before { @transfer_listing.ranking = -1 }
    it { is_expected.not_to be_valid }
  end
  
  context "when new_player is nil" do
    before { @transfer_listing.new_player = nil }
    it { is_expected.not_to be_valid }
  end
  
end
