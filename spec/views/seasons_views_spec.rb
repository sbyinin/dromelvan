require 'rails_helper'

describe "Season", type: :view do
  
  subject { page }

  describe "index view" do
      let!(:season) { FactoryGirl.create(:season) }
      let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
      let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
      let!(:team1) { FactoryGirl.create(:team) }
      let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, team: team1, premier_league: premier_league, match_day: match_day, ranking: 1) }      
      let!(:team2) { FactoryGirl.create(:team) }
      let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, team: team2, premier_league: premier_league, match_day: match_day, ranking: 2) }
      let!(:team3) { FactoryGirl.create(:team) }
      let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, team: team3, premier_league: premier_league, match_day: match_day, ranking: 3) }      
      let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
      let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day) }
      let!(:d11_team1) { FactoryGirl.create(:d11_team) }
      let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team1, d11_league: d11_league, d11_match_day: d11_match_day, ranking: 1) }
      let!(:d11_team2) { FactoryGirl.create(:d11_team) }
      let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_league: d11_league, d11_match_day: d11_match_day, ranking: 2) }
      let!(:d11_team3) { FactoryGirl.create(:d11_team) }
      let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team3, d11_league: d11_league, d11_match_day: d11_match_day, ranking: 3) }      
      let!(:player1) { FactoryGirl.create(:player) }
      let!(:player_season_stat1) { FactoryGirl.create(:player_season_stat, player: player1, season: season, ranking: 1) }
      let!(:player_season_info1) { FactoryGirl.create(:player_season_info, player: player1, season: season) }
      let!(:player2) { FactoryGirl.create(:player) }
      let!(:player_season_stat2) { FactoryGirl.create(:player_season_stat, player: player2, season: season, ranking: 2) }
      let!(:player_season_info2) { FactoryGirl.create(:player_season_info, player: player2, season: season) }
      let!(:player3) { FactoryGirl.create(:player) }
      let!(:player_season_stat3) { FactoryGirl.create(:player_season_stat, player: player3, season: season, ranking: 3) }
      let!(:player_season_info3) { FactoryGirl.create(:player_season_info, player: player3, season: season) }
      
      before do
        visit seasons_path
      end
        
      it_should_behave_like "index view", Season
  
      it { is_expected.to have_selector('div.season-summary h2', text: season.name) }
      it { is_expected.to within(:css, 'div.season-summary h2') { have_link(season.name, season) } }
      
      it { is_expected.to have_selector('div.d11-winner h3', text: d11_team1.name) }
      it { is_expected.to within(:css, 'div.d11-winner h3') { have_link(d11_team1.name, d11_team1) } }
      it { is_expected.to have_selector('div.d11-winner p.d11-league', text: "#{d11_league.name} Leader") }
      it { is_expected.to within(:css, 'div.d11-winner p.d11-league') { have_link(d11_league.name, d11_league) } }      
      it { is_expected.to have_selector('div.d11-winner p.stats span.points', text: "#{d11_team_table_stat1.points} points") }
      it { is_expected.to have_selector('div.d11-winner p.stats span.goals', text: "#{d11_team_table_stat1.goals_for} goals") }
      
      it { is_expected.to have_selector('div.premier-league-winner h3', text: team1.name) }
      it { is_expected.to within(:css, 'div.premier-league-winner h3') { have_link(team1.name, team1) } }
      it { is_expected.to have_selector('div.premier-league-winner p.premier-league', text: "Premier League Leader") }
      it { is_expected.to within(:css, 'div.premier-league-winner p.premier-league') { have_link("Premier League", premier_league) } }      
      it { is_expected.to have_selector('div.premier-league-winner p.stats span.points', text: "#{team_table_stat1.points} points") }
      it { is_expected.to have_selector('div.premier-league-winner p.stats span.goals', text: "#{team_table_stat1.goal_difference} gd") }

      it { is_expected.to have_selector('div.most-valuable-player h3', text: "#{player1.name} (#{player_season_info1.team.code})") }      
      it { is_expected.to within(:css, 'div.most-valuable-player h3') { have_link(player1.name, player1) } }
      it { is_expected.to have_selector('div.most-valuable-player p.most-valuable-player', text: "Most Valuable Player") }
      it { is_expected.to have_selector('div.most-valuable-player p.stats span.points', text: "#{player_season_stat1.points} points") }
      it { is_expected.to have_selector('div.most-valuable-player p.stats span.goals', text: "#{player_season_stat1.goals} goals") }
      
      it { is_expected.to have_selector('div.runners-up h3', text: "Runners Up") }
      # Have to use d11_league.name since the ö in "Drömelvan" for some reason screws things up.
      it { is_expected.to have_selector('div.runners-up h4', text: d11_league.name) }
      it { is_expected.to have_selector('div.runners-up ul#d11-runners-up') }
      it { is_expected.to have_selector('div.runners-up ul#d11-runners-up li', text: "#{d11_team2.name}" ) }
      it { is_expected.to have_selector('div.runners-up ul#d11-runners-up li', text: "#{d11_team3.name}" ) }
      
      it { is_expected.to have_selector('div.runners-up h4', text: "Premier League") }
      it { is_expected.to have_selector('div.runners-up ul#premier-league-runners-up') }
      it { is_expected.to have_selector('div.runners-up ul#premier-league-runners-up li', text: "#{team2.name}" ) }
      it { is_expected.to have_selector('div.runners-up ul#premier-league-runners-up li', text: "#{team3.name}" ) }

      it { is_expected.to have_selector('div.runners-up h4', text: "Most Valuable Player") }
      it { is_expected.to have_selector('div.runners-up ul#most-valuable-player-runners-up') }
      it { is_expected.to have_selector('div.runners-up ul#most-valuable-player-runners-up li', text: "#{player2.name} (#{player_season_info2.team.code})" ) }
      it { is_expected.to have_selector('div.runners-up ul#most-valuable-player-runners-up li', text: "#{player3.name} (#{player_season_info3.team.code})" ) }            
  end

  it_should_behave_like "show view", Season do
    let(:h1_text) { "Season #{resource.name}" }
  end

  pending "final index styling."
  pending "final show layout."
  
end
