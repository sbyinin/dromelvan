require 'rails_helper'

describe "MatchDay", type: :view do
  
  subject { page }

  describe "show view" do        
    describe "navigation links" do
      let!(:premier_league) { FactoryGirl.create(:premier_league) }
      let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1, date: Date.today - 1)}
      let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 2, date: Date.today)}
      let!(:match_day3) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 3, date: Date.today + 1)}
      
      context "with first match day" do
        before { visit match_day_path(match_day1) }
        
        it { is_expected.not_to within(:css, 'p.navigation-links') { have_link('Previous') } }
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Next', match_day2) } }        
      end
      
      context "with second match day" do
        before { visit match_day_path(match_day2) }
        
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Previous', match_day1) } }
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Next', match_day3) } }        
      end

      context "with third match day" do
        before { visit match_day_path(match_day3) }
        
        it { is_expected.to within(:css, 'p.navigation-links') { have_link('Previous', match_day2) } }
        it { is_expected.not_to within(:css, 'p.navigation-links') { have_link('Next') } }        
      end      
    end
    
    describe "match date fixtures" do
      context "when no matches exist" do
        let!(:match_day) { FactoryGirl.create(:match_day)}
        
        before { visit match_day_path(match_day) }
        
        it { is_expected.to have_selector('div.match-date-fixtures', text: 'There are no fixtures for this match day yet. Stay tuned.') }
                
        it { is_expected.to have_selector('div.league-table-container') }
        it { is_expected.to within(:css, 'div.league-table-container div.panel-heading') { have_selector('h2.panel-title', text: "Standings after match day #{match_day.match_day_number}") } }
        it { is_expected.to within(:css, 'div.league-table-container') { have_selector('div.league-table table.league-table') } }
      end
      
      context "when matches exist" do
        let!(:match_day) { FactoryGirl.create(:match_day)}            
        let!(:match1) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 1.day, status: :finished) }
        let!(:match2) { FactoryGirl.create(:match, match_day: match_day, datetime: match1.datetime + 2.day) }
      
        before { visit match_day_path(match_day) }
        
        it { is_expected.to have_selector("div.match-date-fixtures\##{match1.datetime.to_date}") }
        it { is_expected.to within(:css, "div.match-date-fixtures\##{match1.datetime.to_date} div.panel-heading h2.panel-title") { have_link(match1.datetime.to_date.to_formatted_s(:match_date), ".match-date-details-#{match1.datetime.to_date.to_formatted_s(:number)}") } }
        it { is_expected.to within(:css, "div.match-date-fixtures\##{match1.datetime.to_date} div.match-date-fixtures table.match-date-fixtures") { have_selector("div.match-details.match-date-details-#{match1.datetime.to_date.to_formatted_s(:number)}.match-id-details-#{match1.id}") } }
        it { is_expected.to within(:css, "div.match-date-fixtures\##{match1.datetime.to_date} div.match-date-fixtures table.match-date-fixtures") { have_selector("div.match-details.events") } }
        
        it { is_expected.to have_selector("div.match-date-fixtures\##{match2.datetime.to_date}") }
        it { is_expected.to within(:css, "div.match-date-fixtures\##{match2.datetime.to_date} div.panel-heading h2.panel-title") { have_link(match2.datetime.to_date.to_formatted_s(:match_date), ".match-date-details-#{match2.datetime.to_date.to_formatted_s(:number)}") } }
        it { is_expected.to within(:css, "div.match-date-fixtures\##{match2.datetime.to_date} div.match-date-fixtures table.match-date-fixtures") { have_selector("div.match-details.match-date-details-#{match2.datetime.to_date.to_formatted_s(:number)}.match-id-details-#{match2.id}") } }
        it { is_expected.to within(:css, "div.match-date-fixtures\##{match2.datetime.to_date} div.match-date-fixtures table.match-date-fixtures") { have_selector("div.match-details.preview") } }
        
        it { is_expected.to have_selector('div.league-table-container') }
        it { is_expected.to within(:css, 'div.league-table-container div.panel-heading') { have_selector('h2.panel-title', text: "Standings after match day #{match_day.match_day_number}") } }
        it { is_expected.to within(:css, 'div.league-table-container') { have_selector('div.league-table table.league-table') } }        
      end
    end    
        
    it_should_behave_like "show view", MatchDay do
      let(:h1_text) { resource.name }
    end
  end
  
end
