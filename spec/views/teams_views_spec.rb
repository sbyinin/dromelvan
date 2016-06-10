require 'rails_helper'

describe "Team", type: :view do
  
  subject { page }

  # The season select show views need a season
  let!(:season) { FactoryGirl.create(:season) }

  describe "show view" do
    let!(:team_career_squad_stat) { FactoryGirl.create(:team_career_squad_stat, team: resource) }
  
    it_should_behave_like "show view", Team do    
      let(:h1_text) { resource.name }
      
      it { is_expected.to have_selector("div#team-profile") }    
      it { is_expected.to have_selector("div#team-career-squad-stats") }
  
      describe "div#team-season-squad-stats" do
        context "when player season stats do not exist" do
          before { visit team_path(resource) }
          
          it { is_expected.not_to have_selector("div#team-season-squad-stats") }
        end      
      end
      
      context "when player season stats exist" do
        let!(:player) { FactoryGirl.create(:player) }
        let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: season) }
        let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: season, team: resource) }
        
        before { visit team_path(resource) }
        
        it { is_expected.to have_selector("div#team-season-squad-stats") }
      end    
    end
  end
  
  describe "fixtures view" do
    let!(:team) { FactoryGirl.create(:team) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season)}
    
    before { visit show_fixtures_team_path(team, season) }
    
    it { is_expected.to have_selector("div.teams.show-fixtures") }
    it { is_expected.to have_selector("div#team-profile") }
    it { is_expected.to have_selector("div#team-fixtures-and-results") }
    it { is_expected.to have_selector("div#team-season-history") } 
  end
  
end
