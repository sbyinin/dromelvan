require 'rails_helper'

describe "Match", type: :view do
  
  subject { page }

  it_should_behave_like "show view", Match do
    describe "context menu" do
      let(:match) { FactoryGirl.create(:match) }
      
      context "as non-user" do
        before do
          visit match_path(match)
        end
    
        it { is_expected.not_to have_selector("div.context-menu.match") }
      end
      
      context "as user" do
        let(:user) { FactoryGirl.create(:user) }
        
        before do
          sign_in user
          visit match_path(match)
        end
    
        it { is_expected.not_to have_selector("div.context-menu.match") }
      end
    
      context "as admin" do
          let(:admin) { FactoryGirl.create(:admin) }
          
          before do
            sign_in admin
            visit match_path(match)
          end
        
          it { is_expected.to have_selector("div.context-menu.match") }
      end
    end
    
    context "when match is pending" do
      let(:match) { FactoryGirl.create(:match) }
      
      before { visit match_path(match) }
      
      it { is_expected.to have_selector("div.match-details.preview") }
      it { is_expected.not_to have_selector("div.match-details.events") }      
      it { is_expected.not_to have_selector("div.player-statistics") }
      it { is_expected.not_to have_selector("div.player-match-stats-summary") }      
    end
    
    context "when match is not pending" do
      let!(:match) { FactoryGirl.create(:match, status: 2) }
      let!(:team_match_squad_stat1) { FactoryGirl.create(:team_match_squad_stat, match: match, team: match.home_team) }
      let!(:team_match_squad_stat2) { FactoryGirl.create(:team_match_squad_stat, match: match, team: match.away_team) }
      
      before { visit match_path(match) }

      it { is_expected.not_to have_selector("div.match-details.preview") }
      it { is_expected.to have_selector("div.match-details.events") }            
      it { is_expected.to have_selector("div.player-statistics") }
      it { is_expected.to have_selector("div.player-match-stats-summary") }      
    end
    
    let(:h1_text) { "#{resource.match_day.premier_league.name} #{resource.match_day.premier_league.season.name}" }      
  end
  
end
