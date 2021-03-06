require 'rails_helper'

describe "PremierLeague", type: :view do
    
  subject { page }  

  describe "league table view" do
    let!(:premier_league) { FactoryGirl.create(:premier_league) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today - 1.day) }
    
    before do
      visit show_table_premier_league_path(premier_league)
    end
    
    it { is_expected.to have_selector("div.premier-leagues.show-table##{premier_league.id}") }
    it { is_expected.to have_selector('h1', text: "#{premier_league.name} #{premier_league.season.name}") }
    it { is_expected.to have_selector('h2', text: "League table") }
    it { is_expected.to have_selector("div.league-table-filter[data-max-index='0']") }
    it { is_expected.to have_selector("table.premier-league-table.detailed") }
  end

  describe "stats view" do
    let!(:premier_league) { FactoryGirl.create(:premier_league) }
    
    before do
      visit show_stats_premier_league_path(premier_league)
    end
    
    it { is_expected.to have_selector("div.premier-leagues.show-stats##{premier_league.id}") }
    it { is_expected.to have_selector('h1', text: "#{premier_league.name} #{premier_league.season.name}") }
    it { is_expected.to have_selector('h2', text: "Player statistics") }
    it { is_expected.to have_selector("table.player-season-stats") }
  end
  
end
