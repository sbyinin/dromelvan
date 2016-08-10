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
      context "when player season stat and match stat does not exist" do
        let!(:player) { FactoryGirl.create(:player) }
        let!(:player_career_stat) { FactoryGirl.create(:player_career_stat, player: player) }
        
        before { visit player_path(player) }
        
        it { is_expected.not_to have_selector("div#player-match-stats") }
      end
      
      context "when player season stat and match stat exists" do
        let!(:player) { FactoryGirl.create(:player) }
        let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: season) }
        let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
        let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
        let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
        let!(:player_match_stat) { FactoryGirl.create(:player_match_stat, match: match, player: player) }
        let!(:player_career_stat) { FactoryGirl.create(:player_career_stat, player: player) }
        
        before { visit player_path(player) }
        
        it { is_expected.to have_selector("div#player-match-stats") }
      end
    end    
  end
  
end
