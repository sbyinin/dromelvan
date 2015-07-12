require 'rails_helper'

describe "D11Match", type: :view do
  
  subject { page }

  # Need this as long as we're using a dummy stadium photo instead of a d11_team stadium photo.
  let!(:team) { FactoryGirl.create(:team) }
  
  it_should_behave_like "show view", D11Match do
    describe "context menu" do
      let(:d11_match) { FactoryGirl.create(:d11_match) }
      
      context "as non-user" do
        before do
          visit d11_match_path(d11_match)
        end
    
        it { is_expected.not_to have_selector("div.context-menu.d11-match") }
      end
      
      context "as user" do
        let(:user) { FactoryGirl.create(:user) }
        
        before do
          sign_in user
          visit d11_match_path(d11_match)
        end
    
        it { is_expected.not_to have_selector("div.context-menu.d11-match") }
      end
    
      context "as admin" do
          let(:admin) { FactoryGirl.create(:admin) }
          
          before do
            sign_in admin
            visit d11_match_path(d11_match)
          end
        
          it { is_expected.to have_selector("div.context-menu.d11-match") }
      end
    end    
    
    context "when d11_match is pending" do
      let(:d11_match) { FactoryGirl.create(:d11_match) }
      
      before { visit d11_match_path(d11_match) }
      
      it { is_expected.to have_selector("div.match-details.preview") }
      it { is_expected.not_to have_selector("div.match-details.events") }      
      it { is_expected.not_to have_selector("div.player-statistics") }
      it { is_expected.not_to have_selector("div.player-match-stats-summary") }      
    end
    
    context "when d11_match is not pending" do
      let!(:d11_match) { FactoryGirl.create(:d11_match, status: 2) }
      let!(:d11_team_match_squad_stat1) { FactoryGirl.create(:d11_team_match_squad_stat, d11_match: d11_match, d11_team: d11_match.home_d11_team) }
      let!(:d11_team_match_squad_stat2) { FactoryGirl.create(:d11_team_match_squad_stat, d11_match: d11_match, d11_team: d11_match.away_d11_team) }
      
      before { visit d11_match_path(d11_match) }

      it { is_expected.not_to have_selector("div.match-details.preview") }
      it { is_expected.to have_selector("div.match-details.events") }            
      it { is_expected.to have_selector("div.player-statistics") }
      it { is_expected.to have_selector("div.player-match-stats-summary") }      
    end
    
    let(:h1_text) { "#{resource.d11_match_day.d11_league.name} #{resource.d11_match_day.d11_league.season.name}" }      
  end

end
