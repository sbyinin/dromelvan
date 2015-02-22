require 'rails_helper'

describe "Search", type: :view do
  
  subject { page }

  let!(:player) { FactoryGirl.create(:player) }
  let!(:season) { FactoryGirl.create(:season) }
  let!(:position) { FactoryGirl.create(:position) }
  let!(:team) { FactoryGirl.create(:team) }
  let!(:co_owner) { FactoryGirl.create(:user) }
  let!(:d11_team) { FactoryGirl.create(:d11_team, co_owner: co_owner) }
  let!(:player_season_info) { FactoryGirl.create(:player_season_info, player: player, season: season, position: position, team: team, d11_team: d11_team) }

  context "with no matches" do
    before { visit search_path(search: {q: "Foo Bar" }) }
    
    it { is_expected.not_to have_selector("div.search-result.player") }
    it { is_expected.not_to have_selector("div.search-result.team") }
    it { is_expected.not_to have_selector("div.search-result.d11_team") }
  end
  
  describe "with player match" do
    before { visit search_path(search: {q: player.name }) }
    
    it { is_expected.to have_selector("div.search-result.player") }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(player.name, player)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(team.name, team)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(team.code, team)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(d11_team.name, d11_team)} }
    it { is_expected.to within(:css, 'div.search-result.player') { have_link(d11_team.code, d11_team)} }
    
    it { is_expected.not_to have_selector("div.search-result.team") }
    it { is_expected.not_to have_selector("div.search-result.d11_team") }    
  end

  describe "with team match" do
    before { visit search_path(search: {q: team.name }) }
    
    it { is_expected.to have_selector("div.search-result.team") }
    it { is_expected.to within(:css, 'div.search-result.team') { have_link(team.name, team)} }    
    it { is_expected.to within(:css, 'div.search-result.team') { have_selector('div.search-info.established', text: "Established #{team.established}") } }
    it { is_expected.to within(:css, 'div.search-result.team') { have_selector('div.search-info.stadium', text: "#{team.stadium.name}") } }
    it { is_expected.to within(:css, 'div.search-result.team') { have_selector('div.search-info.city', text: "#{team.stadium.city}") } }
    
    it { is_expected.not_to have_selector("div.search-result.player") }
    it { is_expected.not_to have_selector("div.search-result.d11_team") }        
  end

  describe "with d11_team match" do
    before { visit search_path(search: {q: d11_team.name }) }
    
    it { is_expected.to have_selector("div.search-result.d11-team") }
    it { is_expected.to within(:css, 'div.search-result.d11-team') { have_link(d11_team.name, d11_team)} }    
    it { is_expected.to within(:css, 'div.search-result.d11-team') { have_selector('div.search-info.owner', text: "#{d11_team.owner.name}") } }
    it { is_expected.to within(:css, 'div.search-result.d11-team') { have_selector('div.search-info.co-owner', text: "#{d11_team.co_owner.name}") } }
    
    it { is_expected.not_to have_selector("div.search-result.player") }
    it { is_expected.not_to have_selector("div.search-result.team") }        
  end

  pending "search view styling"  
end
