require 'rails_helper'

describe TransferBid, type: :model do
  let(:transfer_day) { FactoryGirl.create(:transfer_day) }
  let(:player) { FactoryGirl.create(:player) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }
  
  before { @transfer_bid = FactoryGirl.create(:transfer_bid, transfer_day: transfer_day, player: player, player_ranking: 1, d11_team: d11_team, d11_team_ranking: 1, fee: 5, active_fee: 5, successful: false) }
  
  subject { @transfer_bid }
  
  it { is_expected.to respond_to(:transfer_day) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:player_ranking) }
  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:d11_team_ranking) }
  it { is_expected.to respond_to(:fee) }
  it { is_expected.to respond_to(:active_fee) }
  it { is_expected.to respond_to(:successful) }
  
  it { is_expected.to be_valid }
  
  describe '#transfer_day' do
    subject { @transfer_bid.transfer_day }
    it { is_expected.to eq transfer_day }
  end

  describe '#player' do
    subject { @transfer_bid.player }
    it { is_expected.to eq player }
  end
  
  describe '#player_ranking' do
    subject { @transfer_bid.player_ranking }
    it { is_expected.to eq 1 }
  end
  
  describe '#d11_team' do
    subject { @transfer_bid.d11_team }
    it { is_expected.to eq d11_team }
  end

  describe '#d11_team_ranking' do
    subject { @transfer_bid.d11_team_ranking }
    it { is_expected.to eq 1 }
  end
  
  describe '#fee' do
    subject { @transfer_bid.fee }
    it { is_expected.to eq 5 }
  end

  describe '#active_fee' do
    subject { @transfer_bid.active_fee }
    it { is_expected.to eq 5 }
  end
  
  describe '#successful' do
    subject { @transfer_bid.successful }
    it { is_expected.to eq false }
  end


  context "when transfer_day is nil" do
    before { @transfer_bid.transfer_day = nil }
    it { is_expected.not_to be_valid }
  end

  context "when player is nil" do
    before { @transfer_bid.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when player_ranking is nil" do
    before { @transfer_bid.player_ranking = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_team is nil" do
    before { @transfer_bid.d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_team_ranking is nil" do
    before { @transfer_bid.d11_team_ranking = nil }
    it { is_expected.not_to be_valid }
  end

  context "when fee is nil" do
    before { @transfer_bid.fee = nil }
    it { is_expected.not_to be_valid }
  end

  context "when fee is too small" do
    before { @transfer_bid.fee = 0 }
    it { is_expected.not_to be_valid }
  end

  context "when fee is invalid" do
    before { @transfer_bid.fee = 6 }
    it { is_expected.not_to be_valid }
  end

  context "when active_fee is nil" do
    before { @transfer_bid.active_fee = nil }
    it { is_expected.not_to be_valid }
  end

  context "when active_fee is invalid" do
    before { @transfer_bid.active_fee = 6 }
    it { is_expected.not_to be_valid }
  end

  context "when active_fee is too small" do
    before { @transfer_bid.active_fee = 0 }
    it { is_expected.not_to be_valid }
  end

  context "when active_fee is greater than fee" do
    before { @transfer_bid.active_fee = 10 }
    it { is_expected.not_to be_valid }
  end
  
  context "when successful is nil" do
    before { @transfer_bid.successful = nil }
    it { is_expected.not_to be_valid }
  end

  describe "default scope order" do
    before { TransferBid.destroy_all }
    
    let!(:transfer_bid1) { FactoryGirl.create(:transfer_bid, player_ranking: 2, d11_team_ranking: 2, fee: 100, active_fee: 100) }
    let!(:transfer_bid2) { FactoryGirl.create(:transfer_bid, player_ranking: 2, d11_team_ranking: 1, fee: 100, active_fee: 5) }
    let!(:transfer_bid3) { FactoryGirl.create(:transfer_bid, player_ranking: 2, d11_team_ranking: 3, fee: 100, active_fee: 100) }
    let!(:transfer_bid4) { FactoryGirl.create(:transfer_bid, player_ranking: 1, d11_team_ranking: 3, fee: 100, active_fee: 100) }
    let!(:transfer_bid5) { FactoryGirl.create(:transfer_bid, player_ranking: 3, d11_team_ranking: 4, fee: 500, active_fee: 500) }
    
    specify { expect(TransferBid.all).to eq [ transfer_bid4, transfer_bid3, transfer_bid1, transfer_bid2, transfer_bid5 ] }
  end
  
end
