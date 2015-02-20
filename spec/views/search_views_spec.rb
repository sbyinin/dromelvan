require 'rails_helper'

describe "Search", type: :view do
  
  subject { page }

  let!(:player) { FactoryGirl.create(:player) }
  let!(:season) { FactoryGirl.create(:season) }
  let!(:position) { FactoryGirl.create(:position) }
  let!(:team) { FactoryGirl.create(:team) }
  let!(:d11_team) { FactoryGirl.create(:d11_team) }
  let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: season, position: position, team: team, d11_team: d11_team) }

  describe "search view" do
    before { visit search_path(search: {q: player.name }) }
    
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(player.name, player)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(team.name, team)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(team.code, team)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(d11_team.name, d11_team)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(d11_team.code, d11_team)} }
  end
  
end
