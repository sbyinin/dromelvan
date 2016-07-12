require 'rails_helper'

describe "D11League", type: :view do
    
  subject { page }  

  describe "league table view" do
    let!(:d11_league) { FactoryGirl.create(:d11_league) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, date: Date.today - 1.day) }
    
    before do
      visit show_table_d11_league_path(d11_league)
    end
    
    it { is_expected.to have_selector("div.d11-leagues.show-table##{d11_league.id}") }
    it { is_expected.to have_selector('h1', text: "#{d11_league.name} #{d11_league.season.name}") }
    it { is_expected.to have_selector('h2', text: "League table") }
    it { is_expected.to have_selector("div.league-table-filter[data-max-index='0']") }
    it { is_expected.to have_selector("table.d11-league-table.detailed") }
  end

  describe "d11 teams view" do
    let!(:d11_league) { FactoryGirl.create(:d11_league) }
    let!(:d11_team) { FactoryGirl.create(:d11_team) }
    let!(:d11_team_season_squad_stat) { FactoryGirl.create(:d11_team_season_squad_stat, d11_team: d11_team, season: d11_league.season) }
    
    before do
      visit show_d11_teams_d11_league_path(d11_league)
    end
    
    it { is_expected.to have_selector("div.d11-leagues.show-d11-teams##{d11_league.id}") }
    it { is_expected.to have_selector("div.d11-team-season-squad-stat") }
  end

end
