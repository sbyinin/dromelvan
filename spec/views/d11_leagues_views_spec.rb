require 'rails_helper'

describe "D11League", type: :view do
    
  subject { page }  

  it_should_behave_like "show view", D11League do
    let(:h1_text) { resource.name }
  end

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

end
