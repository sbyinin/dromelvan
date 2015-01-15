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
  
  describe '#player_match_stats' do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match1) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 1.day) }
    let!(:match2) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now + 1.day) }
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player, match: match1) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player, match: match2) }
    let!(:transfer_window) { FactoryGirl.create(:transfer_window, season: season ) }
    let!(:transfer_day) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window, datetime: DateTime.now ) }
    let!(:transfer_listing) { FactoryGirl.create(:transfer_listing, player: player, transfer_day: transfer_day) }      
    
    specify { expect(transfer_listing.player_match_stats).to eq [ player_match_stat1 ] }
  end
  
  describe ".update_rankings" do
    before { TransferListing.destroy_all }

    describe "after destroy_all" do
      let!(:season) { FactoryGirl.create(:season) }
      let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
      let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
      let!(:match) { FactoryGirl.create(:match, match_day: match_day) }    
      let!(:player1) { FactoryGirl.create(:player) }
      let!(:player2) { FactoryGirl.create(:player) }
      let!(:player3) { FactoryGirl.create(:player) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player1, match: match, rating: 600, lineup: :starting_lineup) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player2, match: match, rating: 800, lineup: :starting_lineup) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player3, match: match, rating: 700, lineup: :starting_lineup) }
      let!(:transfer_window) { FactoryGirl.create(:transfer_window, season: season ) }
      let!(:transfer_day) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window) }    
      let!(:transfer_listing1) { FactoryGirl.create(:transfer_listing, player: player1, transfer_day: transfer_day) }
      let!(:transfer_listing2) { FactoryGirl.create(:transfer_listing, player: player2, transfer_day: transfer_day) }
      let!(:transfer_listing3) { FactoryGirl.create(:transfer_listing, player: player3, transfer_day: transfer_day) }
      
      before do
        TransferListing.update_rankings(transfer_day)
      end

      specify { expect(transfer_listing1.reload.ranking).to eq 3 }
      specify { expect(transfer_listing2.reload.ranking).to eq 1 }
      specify { expect(transfer_listing3.reload.ranking).to eq 2 }
    end
  end
  
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

  describe "default scope order" do
    before { TransferListing.destroy_all }

    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }    
    let!(:player1) { FactoryGirl.create(:player) }
    let!(:player2) { FactoryGirl.create(:player) }
    let!(:player3) { FactoryGirl.create(:player) }
    let!(:player4) { FactoryGirl.create(:player) }
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player1, match: match, rating: 600, lineup: :starting_lineup) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player2, match: match, rating: 800, lineup: :starting_lineup) }
    let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player3, match: match, rating: 700, lineup: :starting_lineup) }
    let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, player: player4, match: match, rating: 700, lineup: :starting_lineup) }
    let!(:d11_team1) { FactoryGirl.create(:d11_team, name: "Bbbb") }
    let!(:d11_team2) { FactoryGirl.create(:d11_team, name: "Aaaa") }
    let!(:transfer_window) { FactoryGirl.create(:transfer_window, season: season ) }
    let!(:transfer_day) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window) }    
    let!(:transfer_listing1) { FactoryGirl.create(:transfer_listing, player: player1, transfer_day: transfer_day, d11_team: d11_team1) }
    let!(:transfer_listing2) { FactoryGirl.create(:transfer_listing, player: player2, transfer_day: transfer_day, d11_team: d11_team1) }
    let!(:transfer_listing3) { FactoryGirl.create(:transfer_listing, player: player3, transfer_day: transfer_day, d11_team: d11_team1) }
    let!(:transfer_listing4) { FactoryGirl.create(:transfer_listing, player: player4, transfer_day: transfer_day, d11_team: d11_team2) }
    
    specify { expect(TransferListing.all).to eq [ transfer_listing4, transfer_listing2, transfer_listing3, transfer_listing1 ] }
  end

end
