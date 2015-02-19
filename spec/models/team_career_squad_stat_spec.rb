require 'rails_helper'

describe TeamCareerSquadStat, type: :model do  
  let(:team) { FactoryGirl.create(:team) }

  before { @team_career_squad_stat = FactoryGirl.create(:team_career_squad_stat, team: team) }
  
  subject { @team_career_squad_stat }

  it { is_expected.to be_valid }

  describe "#summarize_stats" do
    
    context "for defenders" do
      let!(:position) { FactoryGirl.create(:position, defender: true) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, team: team, position: position, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, team: team, position: position, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, team: team, position: position, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, team: team, position: position, lineup: :did_not_participate) }
      let!(:team_career_squad_stat) { FactoryGirl.create(:team_career_squad_stat, team: team) }
            
      specify { expect(team_career_squad_stat.goals).to eq 3 }
      specify { expect(team_career_squad_stat.goal_assists).to eq 3 }
      specify { expect(team_career_squad_stat.own_goals).to eq 3 }
      specify { expect(team_career_squad_stat.goals_conceded).to eq 3 }
      specify { expect(team_career_squad_stat.clean_sheets).to eq 1 }
      specify { expect(team_career_squad_stat.rating).to eq 700 }
      specify { expect(team_career_squad_stat.points).to eq 9 }                    
      specify { expect(team_career_squad_stat.yellow_cards).to eq 2 }
      specify { expect(team_career_squad_stat.red_cards).to eq 2 }
      specify { expect(team_career_squad_stat.man_of_the_match).to eq 1 }
      specify { expect(team_career_squad_stat.shared_man_of_the_match).to eq 1 }
      specify { expect(team_career_squad_stat.games_started).to eq 2 }
      specify { expect(team_career_squad_stat.games_substitute).to eq 1 }
      specify { expect(team_career_squad_stat.games_did_not_participate).to eq 1 }
      specify { expect(team_career_squad_stat.substitutions_on).to eq 1 }
      specify { expect(team_career_squad_stat.substitutions_off).to eq 1 }
      specify { expect(team_career_squad_stat.minutes_played).to eq 265 }
    end
    
    context "for non-defenders" do
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, team: team, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, team: team, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, team: team, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, team: team, lineup: :did_not_participate) }
      let!(:team_career_squad_stat) { FactoryGirl.create(:team_career_squad_stat, team: team) }
      
      specify { expect(team_career_squad_stat.goals).to eq 3 }
      specify { expect(team_career_squad_stat.goal_assists).to eq 3 }
      specify { expect(team_career_squad_stat.own_goals).to eq 3 }
      specify { expect(team_career_squad_stat.goals_conceded).to eq 0 }
      specify { expect(team_career_squad_stat.clean_sheets).to eq 0 }
      specify { expect(team_career_squad_stat.rating).to eq 700 }
      specify { expect(team_career_squad_stat.points).to eq 7 }                    
      specify { expect(team_career_squad_stat.yellow_cards).to eq 2 }
      specify { expect(team_career_squad_stat.red_cards).to eq 2 }
      specify { expect(team_career_squad_stat.man_of_the_match).to eq 1 }
      specify { expect(team_career_squad_stat.shared_man_of_the_match).to eq 1 }
      specify { expect(team_career_squad_stat.games_started).to eq 2 }
      specify { expect(team_career_squad_stat.games_substitute).to eq 1 }
      specify { expect(team_career_squad_stat.games_did_not_participate).to eq 1 }
      specify { expect(team_career_squad_stat.substitutions_on).to eq 1 }
      specify { expect(team_career_squad_stat.substitutions_off).to eq 1 }
      specify { expect(team_career_squad_stat.minutes_played).to eq 265 }      
    end
  end

  it_should_behave_like "team squad stats summary"
  
end
