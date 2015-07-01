require 'rails_helper'

describe "D11MatchDay", type: :view do
  
  subject { page }
  
  describe "show view" do
    describe "context menu" do
      it_should_behave_like "context menu", MatchDay do
        let(:selector) { { css: 'li.dropdown-header', text: resource.name } }
      end
  
      it_should_behave_like "admin context menu", MatchDay do
        let(:selector) { { css: 'li.dropdown-header', text: "Date" } }
      end
            
      it_should_behave_like "admin context menu", MatchDay do
        let(:selector) { { css: 'li.dropdown-header', text: "Statistics" } }
      end            
    end
    
    describe "navigation links" do
      let!(:d11_league) { FactoryGirl.create(:d11_league) }
      let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 1, date: Date.today - 1)}
      let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 2, date: Date.today)}
      let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 3, date: Date.today + 1)}
      
      context "with first match day" do
        before { visit d11_match_day_path(d11_match_day1) }
        
        it { is_expected.not_to within(:css, 'p.navigation-links') { have_link('Previous') } }
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Next', d11_match_day2) } }        
      end
      
      context "with second match day" do
        before { visit d11_match_day_path(d11_match_day2) }
        
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Previous', d11_match_day1) } }
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Next', d11_match_day3) } }        
      end

      context "with third match day" do
        before { visit d11_match_day_path(d11_match_day3) }
        
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Previous', d11_match_day2) } }
        it { is_expected.not_to within(:css, 'p.navigation-links') { have_link('Next') } }        
      end      
    end
    
    describe "match date fixtures" do
      context "when no matches exist" do
        let!(:d11_match_day) { FactoryGirl.create(:d11_match_day) }
        
        before { visit d11_match_day_path(d11_match_day) }
        
        it { is_expected.to have_selector('div.match-date-fixtures', text: 'There are no fixtures for this match day yet. Stay tuned.') }
                
        it { is_expected.to have_selector('div.league-table-container') }
        it { is_expected.to within(:css, 'div.league-table-container') { have_selector('p', text: "Standings after match day #{d11_match_day.match_day_number}") } }
        it { is_expected.to within(:css, 'div.league-table-container') { have_selector('div.league-table table.league-table') } }
      end
      
      context "when matches exist" do
        
        let!(:match_day) { FactoryGirl.create(:match_day) }
        let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, match_day: match_day) }
        let!(:match) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 1.days) }
        let!(:d11_match) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day) }
        let!(:player_match_stat) { FactoryGirl.create(:player_match_stat, match: match, d11_team: d11_match.home_d11_team) }
        
        context "as non-user" do
          before { visit d11_match_day_path(d11_match_day) }
          
          it { is_expected.to have_selector("div.match-date-fixtures\##{match.datetime.to_date}") }
          it { is_expected.to within(:css, "div.match-date-fixtures\##{match.datetime.to_date} table.match-date-fixtures") { have_selector("div.match-details.match-date-details-#{match.datetime.to_date.to_formatted_s(:number)}.match-id-details-#{d11_match.id}") } }
          it { is_expected.to within(:css, "div.match-date-fixtures\##{match.datetime.to_date} table.match-date-fixtures") { have_selector("div.match-details.preview") } }
                    
          it { is_expected.to have_selector('div.league-table-container') }
          it { is_expected.to within(:css, 'div.league-table-container') { have_selector('p', text: "Standings after match day #{d11_match_day.match_day_number}") } }
          it { is_expected.to within(:css, 'div.league-table-container') { have_selector('div.league-table table.league-table') } }
          
          it { is_expected.not_to have_selector('div.match-date-fixtures table.match-date-fixtures td.action-column div.context-menu.d11-match') }
        end
        
        context "as user" do
          let(:user) { FactoryGirl.create(:user) }
          
          before do
            sign_in user
            visit d11_match_day_path(d11_match_day)
          end
          
          it { is_expected.not_to have_selector('div.match-date-fixtures table.match-date-fixtures td.action-column div.context-menu.d11-match') }
        end
        
        context "as admin" do
          let(:admin) { FactoryGirl.create(:admin) }
          
          before do
            sign_in admin
            visit d11_match_day_path(d11_match_day)
          end
          
          it { is_expected.to have_selector('div.match-date-fixtures table.match-date-fixtures td.action-column div.context-menu.d11-match') }
        end        
      end
    end    
    
    it_should_behave_like "show view", D11MatchDay do 
      let(:h1_text) { "#{resource.d11_league.name} #{resource.d11_league.season.name}" }      
    end
  end  
end
