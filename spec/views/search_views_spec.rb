require 'rails_helper'

describe "Search", type: :view do
  
  subject { page }

  # It's tricky to replace ' '  with '+' in search_path parameters so give the player
  # a name without spaces. Actual search function is tested in player_spec anyway.
  let(:player) { FactoryGirl.create(:player, first_name: "", last_name: "Testname") }
  let(:team) { FactoryGirl.create(:team, name: "Testname") }

  describe "search view" do
    before { visit search_path(search: {q: player.name }) }
    
    it { is_expected.to have_link(player.name, player) }
    it { is_expected.to have_link(team.name, team) }
  end
  
  pending "Team and D11 team links and search results."
  
end
