require 'rails_helper'

describe "Player", type: :view do
    
  subject { page }  

  # This is needed so that the default player_season_info created will have values that aren't nil.    
  let!(:team) { FactoryGirl.create(:team, name: "None") }
  let!(:d11_team) { FactoryGirl.create(:d11_team, name: "None") }
  let!(:position) { FactoryGirl.create(:position, name: "Unknown") }
  # The season select show views need a season
  let!(:season) { FactoryGirl.create(:season) }

  it_should_behave_like "show view", Player do
    let(:h1_text) { resource.name }
    
    it { is_expected.to have_selector("div#player-profile") }    
    it { is_expected.to have_selector("div#player-season-stats") }
    it { is_expected.to have_selector("div#player-career-stats") }
    it { is_expected.to have_selector("div#player-transfer-history") }
    
    describe "div#player-match-stats" do
      context "when player season stat does not exist" do
        let!(:player) { FactoryGirl.create(:player) }
        
        before { visit player_path(player) }
        
        it { is_expected.not_to have_selector("div#player-match-stats") }
      end
      
      context "when player season stat exists" do
        let!(:player) { FactoryGirl.create(:player) }
        let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: season) }
        
        before { visit player_path(player) }
        
        it { is_expected.to have_selector("div#player-match-stats") }
      end
    end    
  end
  
end
