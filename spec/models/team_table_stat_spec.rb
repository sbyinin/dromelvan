require 'rails_helper'

describe TeamTableStat, type: :model do
  let(:team) { FactoryGirl.create(:team) }
  let(:premier_league) { FactoryGirl.create(:premier_league) }
  let(:match_day) { FactoryGirl.create(:match_day) }
  
  before { @team_table_stat = FactoryGirl.create(:team_table_stat, team: team, premier_league: premier_league, match_day: match_day) }
  
  subject { @team_table_stat }
  
  it { is_expected.to respond_to(:team) }
  it { is_expected.to respond_to(:premier_league) }
  it { is_expected.to respond_to(:match_day) }
  it { is_expected.to respond_to(:update_stats) }

  it_should_behave_like "table stat"

  describe '#team' do
    specify { expect(@team_table_stat.team).to eq team } 
  end 

  describe '#premier_league' do
    specify { expect(@team_table_stat.premier_league).to eq premier_league } 
  end 
  
  describe '#match_day' do
    specify { expect(@team_table_stat.match_day).to eq match_day } 
  end 

  describe '.update_stats_from' do
    before do
      TeamTableStat.destroy_all
    end
    
    describe 'for whole season' do
      let!(:premier_league) { FactoryGirl.create(:premier_league) }
      let!(:team2) { FactoryGirl.create(:team) }
      
      let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1) }
      let!(:match1) { FactoryGirl.create(:match, match_day: match_day1, home_team: team, away_team: team2, home_team_goals: 2, away_team_goals: 0, status: :finished) }      
      let!(:goal1) { FactoryGirl.create(:goal, match: match1, team: match1.home_team) }
      let!(:goal2) { FactoryGirl.create(:goal, match: match1, team: match1.home_team) }
  
      let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 2) }
      let!(:match2) { FactoryGirl.create(:match, match_day: match_day2, home_team: team, away_team: team2, home_team_goals: 1, away_team_goals: 1, status: :finished) }
      let!(:goal3) { FactoryGirl.create(:goal, match: match2, team: match2.home_team) }
      let!(:goal4) { FactoryGirl.create(:goal, match: match2, team: match2.away_team) }
  
      let!(:match_day3) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 3) }
      let!(:match3) { FactoryGirl.create(:match, match_day: match_day3, home_team: team2, away_team: team, home_team_goals: 2, away_team_goals: 0, status: :finished) }
      let!(:goal5) { FactoryGirl.create(:goal, match: match3, team: match3.home_team) }
      let!(:goal6) { FactoryGirl.create(:goal, match: match3, team: match3.home_team) }

      let!(:match_day4) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 4) }
      let!(:match4) { FactoryGirl.create(:match, match_day: match_day4, home_team: team2, away_team: team, home_team_goals: 3, away_team_goals: 2, status: :active) }
      let!(:goal7) { FactoryGirl.create(:goal, match: match4, team: match4.home_team) }
      let!(:goal8) { FactoryGirl.create(:goal, match: match4, team: match4.home_team) }
      let!(:goal9) { FactoryGirl.create(:goal, match: match4, team: match4.home_team) }
      let!(:goal10) { FactoryGirl.create(:goal, match: match4, team: match4.away_team) }
      let!(:goal11) { FactoryGirl.create(:goal, match: match4, team: match4.away_team) }
      
      let!(:match_day5) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 5) }
      let!(:match5) { FactoryGirl.create(:match, match_day: match_day5, home_team: team2, away_team: team, home_team_goals: 1, away_team_goals: 2, status: :finished) }
      let!(:goal12) { FactoryGirl.create(:goal, match: match5, team: match5.home_team) }
      let!(:goal13) { FactoryGirl.create(:goal, match: match5, team: match5.away_team) }
      let!(:goal14) { FactoryGirl.create(:goal, match: match5, team: match5.away_team) }

      let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, team: team, premier_league: premier_league, match_day: match_day1) }
      let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, team: team, premier_league: premier_league, match_day: match_day2) }
      let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, team: team, premier_league: premier_league, match_day: match_day3) }      
      let!(:team_table_stat4) { FactoryGirl.create(:team_table_stat, team: team, premier_league: premier_league, match_day: match_day4) }
      let!(:team_table_stat5) { FactoryGirl.create(:team_table_stat, team: team, premier_league: premier_league, match_day: match_day5) }      
      let!(:team_table_stat6) { FactoryGirl.create(:team_table_stat, team: team2, premier_league: premier_league, match_day: match_day1) }
      let!(:team_table_stat7) { FactoryGirl.create(:team_table_stat, team: team2, premier_league: premier_league, match_day: match_day2) }
      let!(:team_table_stat8) { FactoryGirl.create(:team_table_stat, team: team2, premier_league: premier_league, match_day: match_day3) }
      let!(:team_table_stat9) { FactoryGirl.create(:team_table_stat, team: team2, premier_league: premier_league, match_day: match_day4) }
      let!(:team_table_stat10) { FactoryGirl.create(:team_table_stat, team: team2, premier_league: premier_league, match_day: match_day5) }
  
      before do
        match1.save
        match2.save
        match3.save
        match4.save
        match5.save
        
        TeamTableStat.update_stats_from(match1)
        team_table_stat1.reload
        team_table_stat2.reload
        team_table_stat3.reload
        team_table_stat4.reload
        team_table_stat5.reload
        team_table_stat6.reload
        team_table_stat7.reload
        team_table_stat8.reload
        team_table_stat9.reload
        team_table_stat10.reload
      end

      specify { expect(team_table_stat1.home_matches_played).to eq 1 }
      specify { expect(team_table_stat1.home_matches_won).to eq 1 }
      specify { expect(team_table_stat1.home_matches_drawn).to eq 0 }
      specify { expect(team_table_stat1.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat1.home_goals_for).to eq 2 }
      specify { expect(team_table_stat1.home_goals_against).to eq 0 }
      specify { expect(team_table_stat1.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat1.home_points).to eq 3 }
      specify { expect(team_table_stat1.away_matches_played).to eq 0 }
      specify { expect(team_table_stat1.away_matches_won).to eq 0 }
      specify { expect(team_table_stat1.away_matches_drawn).to eq 0 }
      specify { expect(team_table_stat1.away_matches_lost).to eq 0 }
      specify { expect(team_table_stat1.away_goals_for).to eq 0 }
      specify { expect(team_table_stat1.away_goals_against).to eq 0 }
      specify { expect(team_table_stat1.away_goal_difference).to eq 0 }
      specify { expect(team_table_stat1.away_points).to eq 0 }
      specify { expect(team_table_stat1.matches_played).to eq 1 }
      specify { expect(team_table_stat1.matches_won).to eq 1 }
      specify { expect(team_table_stat1.matches_drawn).to eq 0 }
      specify { expect(team_table_stat1.matches_lost).to eq 0 }
      specify { expect(team_table_stat1.goals_for).to eq 2 }
      specify { expect(team_table_stat1.goals_against).to eq 0 }
      specify { expect(team_table_stat1.goal_difference).to eq 2 }
      specify { expect(team_table_stat1.points).to eq 3 }

      specify { expect(team_table_stat2.home_matches_played).to eq 2 }
      specify { expect(team_table_stat2.home_matches_won).to eq 1 }
      specify { expect(team_table_stat2.home_matches_drawn).to eq 1 }
      specify { expect(team_table_stat2.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat2.home_goals_for).to eq 3 }
      specify { expect(team_table_stat2.home_goals_against).to eq 1 }
      specify { expect(team_table_stat2.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat2.home_points).to eq 4 }
      specify { expect(team_table_stat2.away_matches_played).to eq 0 }
      specify { expect(team_table_stat2.away_matches_won).to eq 0 }
      specify { expect(team_table_stat2.away_matches_drawn).to eq 0 }
      specify { expect(team_table_stat2.away_matches_lost).to eq 0 }
      specify { expect(team_table_stat2.away_goals_for).to eq 0 }
      specify { expect(team_table_stat2.away_goals_against).to eq 0 }
      specify { expect(team_table_stat2.away_goal_difference).to eq 0 }
      specify { expect(team_table_stat2.away_points).to eq 0 }
      specify { expect(team_table_stat2.matches_played).to eq 2 }
      specify { expect(team_table_stat2.matches_won).to eq 1 }
      specify { expect(team_table_stat2.matches_drawn).to eq 1 }
      specify { expect(team_table_stat2.matches_lost).to eq 0 }
      specify { expect(team_table_stat2.goals_for).to eq 3 }
      specify { expect(team_table_stat2.goals_against).to eq 1 }
      specify { expect(team_table_stat2.goal_difference).to eq 2 }
      specify { expect(team_table_stat2.points).to eq 4 }
      
      specify { expect(team_table_stat3.home_matches_played).to eq 2 }
      specify { expect(team_table_stat3.home_matches_won).to eq 1 }
      specify { expect(team_table_stat3.home_matches_drawn).to eq 1 }
      specify { expect(team_table_stat3.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat3.home_goals_for).to eq 3 }
      specify { expect(team_table_stat3.home_goals_against).to eq 1 }
      specify { expect(team_table_stat3.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat3.home_points).to eq 4 }
      specify { expect(team_table_stat3.away_matches_played).to eq 1 }
      specify { expect(team_table_stat3.away_matches_won).to eq 0 }
      specify { expect(team_table_stat3.away_matches_drawn).to eq 0 }
      specify { expect(team_table_stat3.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat3.away_goals_for).to eq 0 }
      specify { expect(team_table_stat3.away_goals_against).to eq 2 }
      specify { expect(team_table_stat3.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat3.away_points).to eq 0 }
      specify { expect(team_table_stat3.matches_played).to eq 3 }
      specify { expect(team_table_stat3.matches_won).to eq 1 }
      specify { expect(team_table_stat3.matches_drawn).to eq 1 }
      specify { expect(team_table_stat3.matches_lost).to eq 1 }
      specify { expect(team_table_stat3.goals_for).to eq 3 }
      specify { expect(team_table_stat3.goals_against).to eq 3 }
      specify { expect(team_table_stat3.goal_difference).to eq 0 }
      specify { expect(team_table_stat3.points).to eq 4 }

      specify { expect(team_table_stat4.home_matches_played).to eq 2 }
      specify { expect(team_table_stat4.home_matches_won).to eq 1 }
      specify { expect(team_table_stat4.home_matches_drawn).to eq 1 }
      specify { expect(team_table_stat4.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat4.home_goals_for).to eq 3 }
      specify { expect(team_table_stat4.home_goals_against).to eq 1 }
      specify { expect(team_table_stat4.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat4.home_points).to eq 4 }
      specify { expect(team_table_stat4.away_matches_played).to eq 1 }
      specify { expect(team_table_stat4.away_matches_won).to eq 0 }
      specify { expect(team_table_stat4.away_matches_drawn).to eq 0 }
      specify { expect(team_table_stat4.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat4.away_goals_for).to eq 0 }
      specify { expect(team_table_stat4.away_goals_against).to eq 2 }
      specify { expect(team_table_stat4.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat4.away_points).to eq 0 }
      specify { expect(team_table_stat4.matches_played).to eq 3 }
      specify { expect(team_table_stat4.matches_won).to eq 1 }
      specify { expect(team_table_stat4.matches_drawn).to eq 1 }
      specify { expect(team_table_stat4.matches_lost).to eq 1 }
      specify { expect(team_table_stat4.goals_for).to eq 3 }
      specify { expect(team_table_stat4.goals_against).to eq 3 }
      specify { expect(team_table_stat4.goal_difference).to eq 0 }
      specify { expect(team_table_stat4.points).to eq 4 }
  
      specify { expect(team_table_stat5.home_matches_played).to eq 2 }
      specify { expect(team_table_stat5.home_matches_won).to eq 1 }
      specify { expect(team_table_stat5.home_matches_drawn).to eq 1 }
      specify { expect(team_table_stat5.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat5.home_goals_for).to eq 3 }
      specify { expect(team_table_stat5.home_goals_against).to eq 1 }
      specify { expect(team_table_stat5.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat5.home_points).to eq 4 }
      specify { expect(team_table_stat5.away_matches_played).to eq 2 }
      specify { expect(team_table_stat5.away_matches_won).to eq 1 }
      specify { expect(team_table_stat5.away_matches_drawn).to eq 0 }
      specify { expect(team_table_stat5.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat5.away_goals_for).to eq 2 }
      specify { expect(team_table_stat5.away_goals_against).to eq 3 }
      specify { expect(team_table_stat5.away_goal_difference).to eq (-1) }
      specify { expect(team_table_stat5.away_points).to eq 3 }
      specify { expect(team_table_stat5.matches_played).to eq 4 }
      specify { expect(team_table_stat5.matches_won).to eq 2 }
      specify { expect(team_table_stat5.matches_drawn).to eq 1 }
      specify { expect(team_table_stat5.matches_lost).to eq 1 }
      specify { expect(team_table_stat5.goals_for).to eq 5 }
      specify { expect(team_table_stat5.goals_against).to eq 4 }
      specify { expect(team_table_stat5.goal_difference).to eq 1 }
      specify { expect(team_table_stat5.points).to eq 7 }

      specify { expect(team_table_stat6.home_matches_played).to eq 0 }
      specify { expect(team_table_stat6.home_matches_won).to eq 0 }
      specify { expect(team_table_stat6.home_matches_drawn).to eq 0 }
      specify { expect(team_table_stat6.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat6.home_goals_for).to eq 0 }
      specify { expect(team_table_stat6.home_goals_against).to eq 0 }
      specify { expect(team_table_stat6.home_goal_difference).to eq 0 }
      specify { expect(team_table_stat6.home_points).to eq 0 }
      specify { expect(team_table_stat6.away_matches_played).to eq 1 }
      specify { expect(team_table_stat6.away_matches_won).to eq 0 }
      specify { expect(team_table_stat6.away_matches_drawn).to eq 0 }
      specify { expect(team_table_stat6.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat6.away_goals_for).to eq 0 }
      specify { expect(team_table_stat6.away_goals_against).to eq 2 }
      specify { expect(team_table_stat6.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat6.away_points).to eq 0 }
      specify { expect(team_table_stat6.matches_played).to eq 1 }
      specify { expect(team_table_stat6.matches_won).to eq 0 }
      specify { expect(team_table_stat6.matches_drawn).to eq 0 }
      specify { expect(team_table_stat6.matches_lost).to eq 1 }
      specify { expect(team_table_stat6.goals_for).to eq 0 }
      specify { expect(team_table_stat6.goals_against).to eq 2 }
      specify { expect(team_table_stat6.goal_difference).to eq (-2) }
      specify { expect(team_table_stat6.points).to eq 0 }

      specify { expect(team_table_stat7.home_matches_played).to eq 0 }
      specify { expect(team_table_stat7.home_matches_won).to eq 0 }
      specify { expect(team_table_stat7.home_matches_drawn).to eq 0 }
      specify { expect(team_table_stat7.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat7.home_goals_for).to eq 0 }
      specify { expect(team_table_stat7.home_goals_against).to eq 0 }
      specify { expect(team_table_stat7.home_goal_difference).to eq 0 }
      specify { expect(team_table_stat7.home_points).to eq 0 }
      specify { expect(team_table_stat7.away_matches_played).to eq 2 }
      specify { expect(team_table_stat7.away_matches_won).to eq 0 }
      specify { expect(team_table_stat7.away_matches_drawn).to eq 1 }
      specify { expect(team_table_stat7.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat7.away_goals_for).to eq 1 }
      specify { expect(team_table_stat7.away_goals_against).to eq 3 }
      specify { expect(team_table_stat7.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat7.away_points).to eq 1 }
      specify { expect(team_table_stat7.matches_played).to eq 2 }
      specify { expect(team_table_stat7.matches_won).to eq 0 }
      specify { expect(team_table_stat7.matches_drawn).to eq 1 }
      specify { expect(team_table_stat7.matches_lost).to eq 1 }
      specify { expect(team_table_stat7.goals_for).to eq 1 }
      specify { expect(team_table_stat7.goals_against).to eq 3 }
      specify { expect(team_table_stat7.goal_difference).to eq (-2) }
      specify { expect(team_table_stat7.points).to eq 1 }

      specify { expect(team_table_stat8.home_matches_played).to eq 1 }
      specify { expect(team_table_stat8.home_matches_won).to eq 1 }
      specify { expect(team_table_stat8.home_matches_drawn).to eq 0 }
      specify { expect(team_table_stat8.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat8.home_goals_for).to eq 2 }
      specify { expect(team_table_stat8.home_goals_against).to eq 0 }
      specify { expect(team_table_stat8.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat8.home_points).to eq 3 }
      specify { expect(team_table_stat8.away_matches_played).to eq 2 }
      specify { expect(team_table_stat8.away_matches_won).to eq 0 }
      specify { expect(team_table_stat8.away_matches_drawn).to eq 1 }
      specify { expect(team_table_stat8.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat8.away_goals_for).to eq 1 }
      specify { expect(team_table_stat8.away_goals_against).to eq 3 }
      specify { expect(team_table_stat8.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat8.away_points).to eq 1 }
      specify { expect(team_table_stat8.matches_played).to eq 3 }
      specify { expect(team_table_stat8.matches_won).to eq 1 }
      specify { expect(team_table_stat8.matches_drawn).to eq 1 }
      specify { expect(team_table_stat8.matches_lost).to eq 1 }
      specify { expect(team_table_stat8.goals_for).to eq 3 }
      specify { expect(team_table_stat8.goals_against).to eq 3 }
      specify { expect(team_table_stat8.goal_difference).to eq 0 }
      specify { expect(team_table_stat8.points).to eq 4 }

      specify { expect(team_table_stat9.home_matches_played).to eq 1 }
      specify { expect(team_table_stat9.home_matches_won).to eq 1 }
      specify { expect(team_table_stat9.home_matches_drawn).to eq 0 }
      specify { expect(team_table_stat9.home_matches_lost).to eq 0 }
      specify { expect(team_table_stat9.home_goals_for).to eq 2 }
      specify { expect(team_table_stat9.home_goals_against).to eq 0 }
      specify { expect(team_table_stat9.home_goal_difference).to eq 2 }
      specify { expect(team_table_stat9.home_points).to eq 3 }
      specify { expect(team_table_stat9.away_matches_played).to eq 2 }
      specify { expect(team_table_stat9.away_matches_won).to eq 0 }
      specify { expect(team_table_stat9.away_matches_drawn).to eq 1 }
      specify { expect(team_table_stat9.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat9.away_goals_for).to eq 1 }
      specify { expect(team_table_stat9.away_goals_against).to eq 3 }
      specify { expect(team_table_stat9.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat9.away_points).to eq 1 }
      specify { expect(team_table_stat9.matches_played).to eq 3 }
      specify { expect(team_table_stat9.matches_won).to eq 1 }
      specify { expect(team_table_stat9.matches_drawn).to eq 1 }
      specify { expect(team_table_stat9.matches_lost).to eq 1 }
      specify { expect(team_table_stat9.goals_for).to eq 3 }
      specify { expect(team_table_stat9.goals_against).to eq 3 }
      specify { expect(team_table_stat9.goal_difference).to eq 0 }
      specify { expect(team_table_stat9.points).to eq 4 }

      specify { expect(team_table_stat10.home_matches_played).to eq 2 }
      specify { expect(team_table_stat10.home_matches_won).to eq 1 }
      specify { expect(team_table_stat10.home_matches_drawn).to eq 0 }
      specify { expect(team_table_stat10.home_matches_lost).to eq 1 }
      specify { expect(team_table_stat10.home_goals_for).to eq 3 }
      specify { expect(team_table_stat10.home_goals_against).to eq 2 }
      specify { expect(team_table_stat10.home_goal_difference).to eq 1 }
      specify { expect(team_table_stat10.home_points).to eq 3 }
      specify { expect(team_table_stat10.away_matches_played).to eq 2 }
      specify { expect(team_table_stat10.away_matches_won).to eq 0 }
      specify { expect(team_table_stat10.away_matches_drawn).to eq 1 }
      specify { expect(team_table_stat10.away_matches_lost).to eq 1 }
      specify { expect(team_table_stat10.away_goals_for).to eq 1 }
      specify { expect(team_table_stat10.away_goals_against).to eq 3 }
      specify { expect(team_table_stat10.away_goal_difference).to eq (-2) }
      specify { expect(team_table_stat10.away_points).to eq 1 }
      specify { expect(team_table_stat10.matches_played).to eq 4 }
      specify { expect(team_table_stat10.matches_won).to eq 1 }
      specify { expect(team_table_stat10.matches_drawn).to eq 1 }
      specify { expect(team_table_stat10.matches_lost).to eq 2 }
      specify { expect(team_table_stat10.goals_for).to eq 4 }
      specify { expect(team_table_stat10.goals_against).to eq 5 }
      specify { expect(team_table_stat10.goal_difference).to eq (-1) }
      specify { expect(team_table_stat10.points).to eq 4 }

      describe "for subset of season" do
        before do
          match4.status = :finished
          match4.save
          TeamTableStat.update_stats_from(match4)
          team_table_stat1.reload
          team_table_stat2.reload
          team_table_stat3.reload
          team_table_stat4.reload
          team_table_stat5.reload
          team_table_stat6.reload
          team_table_stat7.reload
          team_table_stat8.reload
          team_table_stat9.reload
          team_table_stat10.reload
        end

        specify { expect(team_table_stat1.home_matches_played).to eq 1 }
        specify { expect(team_table_stat1.home_matches_won).to eq 1 }
        specify { expect(team_table_stat1.home_matches_drawn).to eq 0 }
        specify { expect(team_table_stat1.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat1.home_goals_for).to eq 2 }
        specify { expect(team_table_stat1.home_goals_against).to eq 0 }
        specify { expect(team_table_stat1.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat1.home_points).to eq 3 }
        specify { expect(team_table_stat1.away_matches_played).to eq 0 }
        specify { expect(team_table_stat1.away_matches_won).to eq 0 }
        specify { expect(team_table_stat1.away_matches_drawn).to eq 0 }
        specify { expect(team_table_stat1.away_matches_lost).to eq 0 }
        specify { expect(team_table_stat1.away_goals_for).to eq 0 }
        specify { expect(team_table_stat1.away_goals_against).to eq 0 }
        specify { expect(team_table_stat1.away_goal_difference).to eq 0 }
        specify { expect(team_table_stat1.away_points).to eq 0 }
        specify { expect(team_table_stat1.matches_played).to eq 1 }
        specify { expect(team_table_stat1.matches_won).to eq 1 }
        specify { expect(team_table_stat1.matches_drawn).to eq 0 }
        specify { expect(team_table_stat1.matches_lost).to eq 0 }
        specify { expect(team_table_stat1.goals_for).to eq 2 }
        specify { expect(team_table_stat1.goals_against).to eq 0 }
        specify { expect(team_table_stat1.goal_difference).to eq 2 }
        specify { expect(team_table_stat1.points).to eq 3 }
  
        specify { expect(team_table_stat2.home_matches_played).to eq 2 }
        specify { expect(team_table_stat2.home_matches_won).to eq 1 }
        specify { expect(team_table_stat2.home_matches_drawn).to eq 1 }
        specify { expect(team_table_stat2.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat2.home_goals_for).to eq 3 }
        specify { expect(team_table_stat2.home_goals_against).to eq 1 }
        specify { expect(team_table_stat2.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat2.home_points).to eq 4 }
        specify { expect(team_table_stat2.away_matches_played).to eq 0 }
        specify { expect(team_table_stat2.away_matches_won).to eq 0 }
        specify { expect(team_table_stat2.away_matches_drawn).to eq 0 }
        specify { expect(team_table_stat2.away_matches_lost).to eq 0 }
        specify { expect(team_table_stat2.away_goals_for).to eq 0 }
        specify { expect(team_table_stat2.away_goals_against).to eq 0 }
        specify { expect(team_table_stat2.away_goal_difference).to eq 0 }
        specify { expect(team_table_stat2.away_points).to eq 0 }
        specify { expect(team_table_stat2.matches_played).to eq 2 }
        specify { expect(team_table_stat2.matches_won).to eq 1 }
        specify { expect(team_table_stat2.matches_drawn).to eq 1 }
        specify { expect(team_table_stat2.matches_lost).to eq 0 }
        specify { expect(team_table_stat2.goals_for).to eq 3 }
        specify { expect(team_table_stat2.goals_against).to eq 1 }
        specify { expect(team_table_stat2.goal_difference).to eq 2 }
        specify { expect(team_table_stat2.points).to eq 4 }
        
        specify { expect(team_table_stat3.home_matches_played).to eq 2 }
        specify { expect(team_table_stat3.home_matches_won).to eq 1 }
        specify { expect(team_table_stat3.home_matches_drawn).to eq 1 }
        specify { expect(team_table_stat3.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat3.home_goals_for).to eq 3 }
        specify { expect(team_table_stat3.home_goals_against).to eq 1 }
        specify { expect(team_table_stat3.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat3.home_points).to eq 4 }
        specify { expect(team_table_stat3.away_matches_played).to eq 1 }
        specify { expect(team_table_stat3.away_matches_won).to eq 0 }
        specify { expect(team_table_stat3.away_matches_drawn).to eq 0 }
        specify { expect(team_table_stat3.away_matches_lost).to eq 1 }
        specify { expect(team_table_stat3.away_goals_for).to eq 0 }
        specify { expect(team_table_stat3.away_goals_against).to eq 2 }
        specify { expect(team_table_stat3.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat3.away_points).to eq 0 }
        specify { expect(team_table_stat3.matches_played).to eq 3 }
        specify { expect(team_table_stat3.matches_won).to eq 1 }
        specify { expect(team_table_stat3.matches_drawn).to eq 1 }
        specify { expect(team_table_stat3.matches_lost).to eq 1 }
        specify { expect(team_table_stat3.goals_for).to eq 3 }
        specify { expect(team_table_stat3.goals_against).to eq 3 }
        specify { expect(team_table_stat3.goal_difference).to eq 0 }
        specify { expect(team_table_stat3.points).to eq 4 }

        specify { expect(team_table_stat4.home_matches_played).to eq 2 }
        specify { expect(team_table_stat4.home_matches_won).to eq 1 }
        specify { expect(team_table_stat4.home_matches_drawn).to eq 1 }
        specify { expect(team_table_stat4.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat4.home_goals_for).to eq 3 }
        specify { expect(team_table_stat4.home_goals_against).to eq 1 }
        specify { expect(team_table_stat4.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat4.home_points).to eq 4 }
        specify { expect(team_table_stat4.away_matches_played).to eq 2 }
        specify { expect(team_table_stat4.away_matches_won).to eq 0 }
        specify { expect(team_table_stat4.away_matches_drawn).to eq 0 }
        specify { expect(team_table_stat4.away_matches_lost).to eq 2 }
        specify { expect(team_table_stat4.away_goals_for).to eq 2 }
        specify { expect(team_table_stat4.away_goals_against).to eq 5 }
        specify { expect(team_table_stat4.away_goal_difference).to eq (-3) }
        specify { expect(team_table_stat4.away_points).to eq 0 }
        specify { expect(team_table_stat4.matches_played).to eq 4 }
        specify { expect(team_table_stat4.matches_won).to eq 1 }
        specify { expect(team_table_stat4.matches_drawn).to eq 1 }
        specify { expect(team_table_stat4.matches_lost).to eq 2 }
        specify { expect(team_table_stat4.goals_for).to eq 5 }
        specify { expect(team_table_stat4.goals_against).to eq 6 }
        specify { expect(team_table_stat4.goal_difference).to eq (-1) }
        specify { expect(team_table_stat4.points).to eq 4 }

        specify { expect(team_table_stat5.home_matches_played).to eq 2 }
        specify { expect(team_table_stat5.home_matches_won).to eq 1 }
        specify { expect(team_table_stat5.home_matches_drawn).to eq 1 }
        specify { expect(team_table_stat5.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat5.home_goals_for).to eq 3 }
        specify { expect(team_table_stat5.home_goals_against).to eq 1 }
        specify { expect(team_table_stat5.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat5.home_points).to eq 4 }
        specify { expect(team_table_stat5.away_matches_played).to eq 3 }
        specify { expect(team_table_stat5.away_matches_won).to eq 1 }
        specify { expect(team_table_stat5.away_matches_drawn).to eq 0 }
        specify { expect(team_table_stat5.away_matches_lost).to eq 2 }
        specify { expect(team_table_stat5.away_goals_for).to eq 4 }
        specify { expect(team_table_stat5.away_goals_against).to eq 6 }
        specify { expect(team_table_stat5.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat5.away_points).to eq 3 }
        specify { expect(team_table_stat5.matches_played).to eq 5 }
        specify { expect(team_table_stat5.matches_won).to eq 2 }
        specify { expect(team_table_stat5.matches_drawn).to eq 1 }
        specify { expect(team_table_stat5.matches_lost).to eq 2 }
        specify { expect(team_table_stat5.goals_for).to eq 7 }
        specify { expect(team_table_stat5.goals_against).to eq 7 }
        specify { expect(team_table_stat5.goal_difference).to eq 0 }
        specify { expect(team_table_stat5.points).to eq 7 }

        specify { expect(team_table_stat6.home_matches_played).to eq 0 }
        specify { expect(team_table_stat6.home_matches_won).to eq 0 }
        specify { expect(team_table_stat6.home_matches_drawn).to eq 0 }
        specify { expect(team_table_stat6.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat6.home_goals_for).to eq 0 }
        specify { expect(team_table_stat6.home_goals_against).to eq 0 }
        specify { expect(team_table_stat6.home_goal_difference).to eq 0 }
        specify { expect(team_table_stat6.home_points).to eq 0 }
        specify { expect(team_table_stat6.away_matches_played).to eq 1 }
        specify { expect(team_table_stat6.away_matches_won).to eq 0 }
        specify { expect(team_table_stat6.away_matches_drawn).to eq 0 }
        specify { expect(team_table_stat6.away_matches_lost).to eq 1 }
        specify { expect(team_table_stat6.away_goals_for).to eq 0 }
        specify { expect(team_table_stat6.away_goals_against).to eq 2 }
        specify { expect(team_table_stat6.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat6.away_points).to eq 0 }
        specify { expect(team_table_stat6.matches_played).to eq 1 }
        specify { expect(team_table_stat6.matches_won).to eq 0 }
        specify { expect(team_table_stat6.matches_drawn).to eq 0 }
        specify { expect(team_table_stat6.matches_lost).to eq 1 }
        specify { expect(team_table_stat6.goals_for).to eq 0 }
        specify { expect(team_table_stat6.goals_against).to eq 2 }
        specify { expect(team_table_stat6.goal_difference).to eq (-2) }
        specify { expect(team_table_stat6.points).to eq 0 }
  
        specify { expect(team_table_stat7.home_matches_played).to eq 0 }
        specify { expect(team_table_stat7.home_matches_won).to eq 0 }
        specify { expect(team_table_stat7.home_matches_drawn).to eq 0 }
        specify { expect(team_table_stat7.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat7.home_goals_for).to eq 0 }
        specify { expect(team_table_stat7.home_goals_against).to eq 0 }
        specify { expect(team_table_stat7.home_goal_difference).to eq 0 }
        specify { expect(team_table_stat7.home_points).to eq 0 }
        specify { expect(team_table_stat7.away_matches_played).to eq 2 }
        specify { expect(team_table_stat7.away_matches_won).to eq 0 }
        specify { expect(team_table_stat7.away_matches_drawn).to eq 1 }
        specify { expect(team_table_stat7.away_matches_lost).to eq 1 }
        specify { expect(team_table_stat7.away_goals_for).to eq 1 }
        specify { expect(team_table_stat7.away_goals_against).to eq 3 }
        specify { expect(team_table_stat7.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat7.away_points).to eq 1 }
        specify { expect(team_table_stat7.matches_played).to eq 2 }
        specify { expect(team_table_stat7.matches_won).to eq 0 }
        specify { expect(team_table_stat7.matches_drawn).to eq 1 }
        specify { expect(team_table_stat7.matches_lost).to eq 1 }
        specify { expect(team_table_stat7.goals_for).to eq 1 }
        specify { expect(team_table_stat7.goals_against).to eq 3 }
        specify { expect(team_table_stat7.goal_difference).to eq (-2) }
        specify { expect(team_table_stat7.points).to eq 1 }
  
        specify { expect(team_table_stat8.home_matches_played).to eq 1 }
        specify { expect(team_table_stat8.home_matches_won).to eq 1 }
        specify { expect(team_table_stat8.home_matches_drawn).to eq 0 }
        specify { expect(team_table_stat8.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat8.home_goals_for).to eq 2 }
        specify { expect(team_table_stat8.home_goals_against).to eq 0 }
        specify { expect(team_table_stat8.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat8.home_points).to eq 3 }
        specify { expect(team_table_stat8.away_matches_played).to eq 2 }
        specify { expect(team_table_stat8.away_matches_won).to eq 0 }
        specify { expect(team_table_stat8.away_matches_drawn).to eq 1 }
        specify { expect(team_table_stat8.away_matches_lost).to eq 1 }
        specify { expect(team_table_stat8.away_goals_for).to eq 1 }
        specify { expect(team_table_stat8.away_goals_against).to eq 3 }
        specify { expect(team_table_stat8.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat8.away_points).to eq 1 }
        specify { expect(team_table_stat8.matches_played).to eq 3 }
        specify { expect(team_table_stat8.matches_won).to eq 1 }
        specify { expect(team_table_stat8.matches_drawn).to eq 1 }
        specify { expect(team_table_stat8.matches_lost).to eq 1 }
        specify { expect(team_table_stat8.goals_for).to eq 3 }
        specify { expect(team_table_stat8.goals_against).to eq 3 }
        specify { expect(team_table_stat8.goal_difference).to eq 0 }
        specify { expect(team_table_stat8.points).to eq 4 }

        specify { expect(team_table_stat9.home_matches_played).to eq 2 }
        specify { expect(team_table_stat9.home_matches_won).to eq 2 }
        specify { expect(team_table_stat9.home_matches_drawn).to eq 0 }
        specify { expect(team_table_stat9.home_matches_lost).to eq 0 }
        specify { expect(team_table_stat9.home_goals_for).to eq 5 }
        specify { expect(team_table_stat9.home_goals_against).to eq 2 }
        specify { expect(team_table_stat9.home_goal_difference).to eq 3 }
        specify { expect(team_table_stat9.home_points).to eq 6 }
        specify { expect(team_table_stat9.away_matches_played).to eq 2 }
        specify { expect(team_table_stat9.away_matches_won).to eq 0 }
        specify { expect(team_table_stat9.away_matches_drawn).to eq 1 }
        specify { expect(team_table_stat9.away_matches_lost).to eq 1 }
        specify { expect(team_table_stat9.away_goals_for).to eq 1 }
        specify { expect(team_table_stat9.away_goals_against).to eq 3 }
        specify { expect(team_table_stat9.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat9.away_points).to eq 1 }
        specify { expect(team_table_stat9.matches_played).to eq 4 }
        specify { expect(team_table_stat9.matches_won).to eq 2 }
        specify { expect(team_table_stat9.matches_drawn).to eq 1 }
        specify { expect(team_table_stat9.matches_lost).to eq 1 }
        specify { expect(team_table_stat9.goals_for).to eq 6 }
        specify { expect(team_table_stat9.goals_against).to eq 5 }
        specify { expect(team_table_stat9.goal_difference).to eq 1 }
        specify { expect(team_table_stat9.points).to eq 7 }

        specify { expect(team_table_stat10.home_matches_played).to eq 3 }
        specify { expect(team_table_stat10.home_matches_won).to eq 2 }
        specify { expect(team_table_stat10.home_matches_drawn).to eq 0 }
        specify { expect(team_table_stat10.home_matches_lost).to eq 1 }
        specify { expect(team_table_stat10.home_goals_for).to eq 6 }
        specify { expect(team_table_stat10.home_goals_against).to eq 4 }
        specify { expect(team_table_stat10.home_goal_difference).to eq 2 }
        specify { expect(team_table_stat10.home_points).to eq 6 }
        specify { expect(team_table_stat10.away_matches_played).to eq 2 }
        specify { expect(team_table_stat10.away_matches_won).to eq 0 }
        specify { expect(team_table_stat10.away_matches_drawn).to eq 1 }
        specify { expect(team_table_stat10.away_matches_lost).to eq 1 }
        specify { expect(team_table_stat10.away_goals_for).to eq 1 }
        specify { expect(team_table_stat10.away_goals_against).to eq 3 }
        specify { expect(team_table_stat10.away_goal_difference).to eq (-2) }
        specify { expect(team_table_stat10.away_points).to eq 1 }
        specify { expect(team_table_stat10.matches_played).to eq 5 }
        specify { expect(team_table_stat10.matches_won).to eq 2 }
        specify { expect(team_table_stat10.matches_drawn).to eq 1 }
        specify { expect(team_table_stat10.matches_lost).to eq 2 }
        specify { expect(team_table_stat10.goals_for).to eq 7 }
        specify { expect(team_table_stat10.goals_against).to eq 7 }
        specify { expect(team_table_stat10.goal_difference).to eq 0 }
        specify { expect(team_table_stat10.points).to eq 7 }        
      end
    end
  end

  describe '.update_rankings' do
    before { TeamTableStat.destroy_all }
    
    let!(:match_day) { FactoryGirl.create(:match_day) }
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, match_day: match_day, home_matches_won: 2, away_matches_drawn: 1) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, match_day: match_day, home_matches_won: 1, home_matches_drawn: 1, away_matches_won: 1, away_matches_drawn: 1) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, match_day: match_day, away_matches_won: 2) }
    
    before do
      TeamTableStat.update_rankings(match_day)
      team_table_stat1.reload
      team_table_stat2.reload
      team_table_stat3.reload
    end
    
    specify { expect(team_table_stat1.ranking).to eq 2 }
    specify { expect(team_table_stat2.ranking).to eq 1 }
    specify { expect(team_table_stat3.ranking).to eq 3 }

    specify { expect(team_table_stat1.home_ranking).to eq 1 }
    specify { expect(team_table_stat2.home_ranking).to eq 2 }
    specify { expect(team_table_stat3.home_ranking).to eq 3 }

    specify { expect(team_table_stat1.away_ranking).to eq 3 }
    specify { expect(team_table_stat2.away_ranking).to eq 2 }
    specify { expect(team_table_stat3.away_ranking).to eq 1 }    
  end

  describe '.update_rankings_from' do
    before { TeamTableStat.destroy_all }
    
    let!(:premier_league) { FactoryGirl.create(:premier_league) }
    let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today - 1.day, match_day_number: 1) }
    let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today, match_day_number: 2) }
    let!(:match_day3) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today + 1.day, match_day_number: 3) }
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, match_day: match_day1) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, team: team_table_stat1.team, match_day: match_day2) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, team: team_table_stat1.team, match_day: match_day3) }
    
    before do
      TeamTableStat.update_rankings_from(match_day2)
      team_table_stat1.reload
      team_table_stat2.reload
      team_table_stat3.reload
    end
    
    specify { expect(team_table_stat1.ranking).to eq 0 }
    specify { expect(team_table_stat2.ranking).to eq 1 }
    specify { expect(team_table_stat3.ranking).to eq 1 }
    specify { expect(team_table_stat1.previous_ranking).to eq 0 }
    specify { expect(team_table_stat2.previous_ranking).to eq 0 }
    specify { expect(team_table_stat3.previous_ranking).to eq 1 }
    
    specify { expect(team_table_stat1.home_ranking).to eq 0 }
    specify { expect(team_table_stat2.home_ranking).to eq 1 }
    specify { expect(team_table_stat3.home_ranking).to eq 1 }

    specify { expect(team_table_stat1.away_ranking).to eq 0 }
    specify { expect(team_table_stat2.away_ranking).to eq 1 }
    specify { expect(team_table_stat3.away_ranking).to eq 1 }    
  end

  context "when team is nil" do
    before { @team_table_stat.team = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when premier_league is nil" do
    before { @team_table_stat.premier_league = nil }
    it { is_expected.not_to be_valid }
  end 

  context "when match_day is nil" do
    before { @team_table_stat.match_day = nil }
    it { is_expected.not_to be_valid }
  end 

  describe "form_points" do
    let!(:team1) { FactoryGirl.create(:team) }
    let!(:team2) { FactoryGirl.create(:team) }
    let!(:match_day) { FactoryGirl.create(:match_day) }
    let!(:match1) { FactoryGirl.create(:match, match_day: match_day, status: :finished, home_team: team1, away_team: team2, home_team_goals: 1, away_team_goals: 0) }
    let!(:goal1) { FactoryGirl.create(:goal, match: match1, team: match1.home_team) }
    let!(:match2) { FactoryGirl.create(:match, match_day: match_day, status: :finished, home_team: team1, away_team: team2, home_team_goals: 0, away_team_goals: 1) }
    let!(:goal2) { FactoryGirl.create(:goal, match: match2, team: match2.away_team) }
    let!(:match3) { FactoryGirl.create(:match, match_day: match_day, status: :finished, home_team: team1, away_team: team2, home_team_goals: 0, away_team_goals: 0) }
    let!(:match4) { FactoryGirl.create(:match, match_day: match_day, status: :finished, home_team: team1, away_team: team2, home_team_goals: 1, away_team_goals: 0) }
    let!(:goal3) { FactoryGirl.create(:goal, match: match4, team: match4.home_team) }
    let!(:match5) { FactoryGirl.create(:match, match_day: match_day, status: :finished, home_team: team1, away_team: team2, home_team_goals: 1, away_team_goals: 0) }
    let!(:goal4) { FactoryGirl.create(:goal, match: match5, team: match5.home_team) }
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, team: team1, match_day: match_day)}
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, team: team2, match_day: match_day)}

    before do
      match1.save
      match2.save
      match3.save
      match4.save
      match5.save
      team_table_stat1.save
      team_table_stat2.save
    end
    
    specify { expect(team_table_stat1.form_points).to eq 10 }
    specify { expect(team_table_stat2.form_points).to eq 4 }
  end

  describe "default scope order" do
    before { TeamTableStat.destroy_all }
    
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, ranking: 3) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, ranking: 4) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, ranking: 1) }
    let!(:team_table_stat4) { FactoryGirl.create(:team_table_stat, ranking: 2) }
    
    specify { expect(TeamTableStat.all).to eq [ team_table_stat3, team_table_stat4, team_table_stat1, team_table_stat2 ] }
  end

  describe "combined_ordered and home_ordered scope order" do
    before { TeamTableStat.destroy_all }
    let!(:team1) { FactoryGirl.create(:team, name: "B") }
    let!(:team2) { FactoryGirl.create(:team, name: "A") }
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, home_matches_won: 2) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, home_matches_won: 1) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, home_matches_won: 4) }
    let!(:team_table_stat4) { FactoryGirl.create(:team_table_stat, home_matches_won: 3) }
    let!(:team_table_stat5) { FactoryGirl.create(:team_table_stat, home_matches_won: 3, home_goals_for: 2, home_goals_against: 1) }
    let!(:team_table_stat6) { FactoryGirl.create(:team_table_stat, home_matches_won: 3, home_goals_for: 2, home_goals_against: 2, team: team1) }
    let!(:team_table_stat7) { FactoryGirl.create(:team_table_stat, home_matches_won: 3, home_goals_for: 2, home_goals_against: 2, team: team2) }
    
    specify { expect(TeamTableStat.combined_ordered).to eq [ team_table_stat3, team_table_stat5, team_table_stat7, team_table_stat6, team_table_stat4, team_table_stat1, team_table_stat2 ] }
    specify { expect(TeamTableStat.home_ordered).to eq [ team_table_stat3, team_table_stat5, team_table_stat7, team_table_stat6, team_table_stat4, team_table_stat1, team_table_stat2 ] }
  end
  
  describe "away_ordered scope order" do
    before { TeamTableStat.destroy_all }
    let!(:team1) { FactoryGirl.create(:team, name: "B") }
    let!(:team2) { FactoryGirl.create(:team, name: "A") }
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, away_matches_won: 2) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, away_matches_won: 1) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, away_matches_won: 4) }
    let!(:team_table_stat4) { FactoryGirl.create(:team_table_stat, away_matches_won: 3) }
    let!(:team_table_stat5) { FactoryGirl.create(:team_table_stat, away_matches_won: 3, away_goals_for: 2, away_goals_against: 1) }
    let!(:team_table_stat6) { FactoryGirl.create(:team_table_stat, away_matches_won: 3, away_goals_for: 2, away_goals_against: 2, team: team1) }
    let!(:team_table_stat7) { FactoryGirl.create(:team_table_stat, away_matches_won: 3, away_goals_for: 2, away_goals_against: 2, team: team2) }
    
    specify { expect(TeamTableStat.away_ordered).to eq [ team_table_stat3, team_table_stat5, team_table_stat7, team_table_stat6, team_table_stat4, team_table_stat1, team_table_stat2 ] }
  end
  
  describe "date_ordered scope order" do
    before { TeamTableStat.destroy_all }
    
    let!(:match_day1) { FactoryGirl.create(:match_day, date: Date.today - 1.day, match_day_number: 1) }
    let!(:match_day2) { FactoryGirl.create(:match_day, date: Date.today - 1.day, match_day_number: 2) }
    let!(:match_day3) { FactoryGirl.create(:match_day, date: Date.today, match_day_number: 1) }
    let!(:match_day4) { FactoryGirl.create(:match_day, date: Date.today, match_day_number: 2) }
    let!(:team_table_stat1) { FactoryGirl.create(:team_table_stat, match_day: match_day3) }
    let!(:team_table_stat2) { FactoryGirl.create(:team_table_stat, match_day: match_day4) }
    let!(:team_table_stat3) { FactoryGirl.create(:team_table_stat, match_day: match_day1) }
    let!(:team_table_stat4) { FactoryGirl.create(:team_table_stat, match_day: match_day2) }
    
    specify { expect(TeamTableStat.date_ordered).to eq [ team_table_stat3, team_table_stat4, team_table_stat1, team_table_stat2 ] }
  end

end
