require 'rails_helper'

describe "TransferDay", type: :view do
  
  subject { page }

  describe "show view" do
    it_should_behave_like "show view", TransferDay do
      let(:h1_text) { resource.name }
      
      it { is_expected.to have_selector("div#transfer-day-transfers") }    
      it { is_expected.to have_selector("div#transfer-day-highest-bids") }
      it { is_expected.to have_selector("div#transfer-day-top-transfer-listings") }
      
      context "when dependents don't exist" do
        before { visit transfer_day_path(resource) }
        
        it { is_expected.not_to have_selector("table.transfers") }
        it { is_expected.not_to have_selector("table.transfer-bids") }
        it { is_expected.not_to have_selector("table.transfer-listings") }
      end
      
      context "when dependents exist" do
        let!(:player) { FactoryGirl.create(:player) }
        let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: resource.transfer_window.season) }
        let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: resource.transfer_window.season) }
        let!(:transfer) { FactoryGirl.create(:transfer, transfer_day: resource, player: player) }
        let!(:transfer_bid) { FactoryGirl.create(:transfer_bid, transfer_day: resource, player: player) }
        let!(:transfer_listing) { FactoryGirl.create(:transfer_listing, transfer_day: resource, player: player) }
        
        before { visit transfer_day_path(resource) }
        
        it { is_expected.to have_selector("table.transfers") }
        it { is_expected.to have_selector("table.transfer-bids") }
        it { is_expected.to have_selector("table.transfer-listings") }
      end      
    end
  end

  describe "transfer_listings view" do
    let!(:transfer_day) { FactoryGirl.create(:transfer_day) }
    
    before { visit show_transfer_listings_transfer_day_path(transfer_day) }
    
    it { is_expected.to have_selector("div#transfer-day-transfer-listings") }
    it { is_expected.to have_selector("div#transfer-day-most-expensive-transfers") }    
    it { is_expected.to have_selector("div#transfer-day-highest-bids") }
    
    context "when dependents don't exist" do
      before { visit show_transfer_listings_transfer_day_path(transfer_day) }
      
      it { is_expected.not_to have_selector("table.transfers") }
      it { is_expected.not_to have_selector("table.transfer-bids") }
      it { is_expected.not_to have_selector("table.transfer-listings") }
    end

    context "when dependents exist" do
      let!(:player) { FactoryGirl.create(:player) }
      let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: transfer_day.transfer_window.season) }
      let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: transfer_day.transfer_window.season) }
      let!(:transfer) { FactoryGirl.create(:transfer, transfer_day: transfer_day, player: player) }
      let!(:transfer_bid) { FactoryGirl.create(:transfer_bid, transfer_day: transfer_day, player: player) }
      let!(:transfer_listing) { FactoryGirl.create(:transfer_listing, transfer_day: transfer_day, player: player) }
      
      before { visit show_transfer_listings_transfer_day_path(transfer_day) }
      
      it { is_expected.to have_selector("table.transfers") }
      it { is_expected.to have_selector("table.transfer-bids") }
      it { is_expected.to have_selector("table.transfer-listings") }
    end          
  end
  
end
