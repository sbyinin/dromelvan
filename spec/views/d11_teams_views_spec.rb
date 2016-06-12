require 'rails_helper'

describe "D11Team", type: :view do
  
  subject { page }

  # The season select show views need a season
  let!(:season) { FactoryGirl.create(:season) }

  describe "show view" do
    let!(:d11_team_career_squad_stat) { FactoryGirl.create(:d11_team_career_squad_stat, d11_team: resource) }

    it_should_behave_like "show view", D11Team do
      let(:h1_text) { resource.name }
      
      it { is_expected.to have_selector("div#d11-team-profile") }    
      it { is_expected.to have_selector("div#d11-team-career-squad-stats") }
      describe "div#d11-team-season-squad-stats" do
        
        context "when player season stats do not exist" do
          before { visit d11_team_path(resource) }
          
          it { is_expected.not_to have_selector("div#d11-team-season-squad-stats") }
        end      
      end
      
      context "when player season stats exist" do
        let!(:player) { FactoryGirl.create(:player) }
        let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: season) }
        let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: season, d11_team: resource) }
        
        before { visit d11_team_path(resource) }
        
        it { is_expected.to have_selector("div#d11-team-season-squad-stats") }
      end    
    end
    
  end
  
end
