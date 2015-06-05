require 'rails_helper'

describe D11TeamTableStat, type: :model do
  let(:d11_team) { FactoryGirl.create(:d11_team) }
  let(:d11_league) { FactoryGirl.create(:d11_league) }
  let(:d11_match_day) { FactoryGirl.create(:d11_match_day) }

  before { @d11_team_table_stat = FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team, d11_league: d11_league, d11_match_day: d11_match_day) }
  
  subject { @d11_team_table_stat }

  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:d11_league) }
  it { is_expected.to respond_to(:d11_match_day) }
  it { is_expected.to respond_to(:update_stats) }

  it_should_behave_like "table stat"

  describe '#d11_team' do
    specify { expect(@d11_team_table_stat.d11_team).to eq d11_team } 
  end 

  describe '#d11_league' do
    specify { expect(@d11_team_table_stat.d11_league).to eq d11_league } 
  end 
  
  describe '#d11_match_day' do
    specify { expect(@d11_team_table_stat.d11_match_day).to eq d11_match_day } 
  end 

  describe '.update_stats_from' do
    before do
      D11TeamTableStat.destroy_all
    end
    
    describe 'for whole season' do
      let!(:d11_league) { FactoryGirl.create(:d11_league) }
      let!(:d11_team2) { FactoryGirl.create(:d11_team) }
      
      let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 1) }
      let!(:d11_match1) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day1, home_d11_team: d11_team, away_d11_team: d11_team2, home_team_points: 5, away_team_points: 0, status: :finished) }      
  
      let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 2) }
      let!(:d11_match2) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day2, home_d11_team: d11_team, away_d11_team: d11_team2, home_team_points: 1, away_team_points: 1, status: :finished) }
  
      let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 3) }
      let!(:d11_match3) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day3, home_d11_team: d11_team2, away_d11_team: d11_team, home_team_points: 5, away_team_points: 0, status: :finished) }

      let!(:d11_match_day4) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 4) }
      let!(:d11_match4) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day4, home_d11_team: d11_team2, away_d11_team: d11_team, home_team_points: 10, away_team_points: 5, status: :active) }
      
      let!(:d11_match_day5) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 5) }
      let!(:d11_match5) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day5, home_d11_team: d11_team2, away_d11_team: d11_team, home_team_points: 1, away_team_points: 5, status: :finished) }


      let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team, d11_league: d11_league, d11_match_day: d11_match_day1) }
      let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team, d11_league: d11_league, d11_match_day: d11_match_day2) }
      let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team, d11_league: d11_league, d11_match_day: d11_match_day3) }      
      let!(:d11_team_table_stat4) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team, d11_league: d11_league, d11_match_day: d11_match_day4) }
      let!(:d11_team_table_stat5) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team, d11_league: d11_league, d11_match_day: d11_match_day5) }      
      let!(:d11_team_table_stat6) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_league: d11_league, d11_match_day: d11_match_day1) }
      let!(:d11_team_table_stat7) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_league: d11_league, d11_match_day: d11_match_day2) }
      let!(:d11_team_table_stat8) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_league: d11_league, d11_match_day: d11_match_day3) }
      let!(:d11_team_table_stat9) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_league: d11_league, d11_match_day: d11_match_day4) }
      let!(:d11_team_table_stat10) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_league: d11_league, d11_match_day: d11_match_day5) }
  
      before do
        D11TeamTableStat.update_stats_from(d11_match1)
        d11_team_table_stat1.reload
        d11_team_table_stat2.reload
        d11_team_table_stat3.reload
        d11_team_table_stat4.reload
        d11_team_table_stat5.reload
        d11_team_table_stat6.reload
        d11_team_table_stat7.reload
        d11_team_table_stat8.reload
        d11_team_table_stat9.reload
        d11_team_table_stat10.reload
      end

      specify { expect(d11_team_table_stat1.home_matches_played).to eq 1 }
      specify { expect(d11_team_table_stat1.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat1.home_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat1.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat1.home_goals_for).to eq 2 }
      specify { expect(d11_team_table_stat1.home_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat1.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat1.home_points).to eq 3 }
      specify { expect(d11_team_table_stat1.away_matches_played).to eq 0 }
      specify { expect(d11_team_table_stat1.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat1.away_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat1.away_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat1.away_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat1.away_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat1.away_goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat1.away_points).to eq 0 }
      specify { expect(d11_team_table_stat1.matches_played).to eq 1 }
      specify { expect(d11_team_table_stat1.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat1.matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat1.matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat1.goals_for).to eq 2 }
      specify { expect(d11_team_table_stat1.goals_against).to eq 0 }
      specify { expect(d11_team_table_stat1.goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat1.points).to eq 3 }

      specify { expect(d11_team_table_stat2.home_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat2.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat2.home_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat2.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat2.home_goals_for).to eq 3 }
      specify { expect(d11_team_table_stat2.home_goals_against).to eq 1 }
      specify { expect(d11_team_table_stat2.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat2.home_points).to eq 4 }
      specify { expect(d11_team_table_stat2.away_matches_played).to eq 0 }
      specify { expect(d11_team_table_stat2.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat2.away_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat2.away_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat2.away_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat2.away_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat2.away_goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat2.away_points).to eq 0 }
      specify { expect(d11_team_table_stat2.matches_played).to eq 2 }
      specify { expect(d11_team_table_stat2.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat2.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat2.matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat2.goals_for).to eq 3 }
      specify { expect(d11_team_table_stat2.goals_against).to eq 1 }
      specify { expect(d11_team_table_stat2.goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat2.points).to eq 4 }
      
      specify { expect(d11_team_table_stat3.home_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat3.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat3.home_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat3.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat3.home_goals_for).to eq 3 }
      specify { expect(d11_team_table_stat3.home_goals_against).to eq 1 }
      specify { expect(d11_team_table_stat3.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat3.home_points).to eq 4 }
      specify { expect(d11_team_table_stat3.away_matches_played).to eq 1 }
      specify { expect(d11_team_table_stat3.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat3.away_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat3.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat3.away_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat3.away_goals_against).to eq 2 }
      specify { expect(d11_team_table_stat3.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat3.away_points).to eq 0 }
      specify { expect(d11_team_table_stat3.matches_played).to eq 3 }
      specify { expect(d11_team_table_stat3.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat3.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat3.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat3.goals_for).to eq 3 }
      specify { expect(d11_team_table_stat3.goals_against).to eq 3 }
      specify { expect(d11_team_table_stat3.goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat3.points).to eq 4 }

      specify { expect(d11_team_table_stat4.home_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat4.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat4.home_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat4.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat4.home_goals_for).to eq 3 }
      specify { expect(d11_team_table_stat4.home_goals_against).to eq 1 }
      specify { expect(d11_team_table_stat4.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat4.home_points).to eq 4 }
      specify { expect(d11_team_table_stat4.away_matches_played).to eq 1 }
      specify { expect(d11_team_table_stat4.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat4.away_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat4.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat4.away_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat4.away_goals_against).to eq 2 }
      specify { expect(d11_team_table_stat4.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat4.away_points).to eq 0 }
      specify { expect(d11_team_table_stat4.matches_played).to eq 3 }
      specify { expect(d11_team_table_stat4.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat4.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat4.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat4.goals_for).to eq 3 }
      specify { expect(d11_team_table_stat4.goals_against).to eq 3 }
      specify { expect(d11_team_table_stat4.goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat4.points).to eq 4 }
  
      specify { expect(d11_team_table_stat5.home_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat5.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat5.home_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat5.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat5.home_goals_for).to eq 3 }
      specify { expect(d11_team_table_stat5.home_goals_against).to eq 1 }
      specify { expect(d11_team_table_stat5.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat5.home_points).to eq 4 }
      specify { expect(d11_team_table_stat5.away_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat5.away_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat5.away_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat5.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat5.away_goals_for).to eq 2 }
      specify { expect(d11_team_table_stat5.away_goals_against).to eq 3 }
      specify { expect(d11_team_table_stat5.away_goal_difference).to eq (-1) }
      specify { expect(d11_team_table_stat5.away_points).to eq 3 }
      specify { expect(d11_team_table_stat5.matches_played).to eq 4 }
      specify { expect(d11_team_table_stat5.matches_won).to eq 2 }
      specify { expect(d11_team_table_stat5.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat5.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat5.goals_for).to eq 5 }
      specify { expect(d11_team_table_stat5.goals_against).to eq 4 }
      specify { expect(d11_team_table_stat5.goal_difference).to eq 1 }
      specify { expect(d11_team_table_stat5.points).to eq 7 }

      specify { expect(d11_team_table_stat6.home_matches_played).to eq 0 }
      specify { expect(d11_team_table_stat6.home_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat6.home_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat6.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat6.home_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat6.home_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat6.home_goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat6.home_points).to eq 0 }
      specify { expect(d11_team_table_stat6.away_matches_played).to eq 1 }
      specify { expect(d11_team_table_stat6.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat6.away_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat6.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat6.away_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat6.away_goals_against).to eq 2 }
      specify { expect(d11_team_table_stat6.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat6.away_points).to eq 0 }
      specify { expect(d11_team_table_stat6.matches_played).to eq 1 }
      specify { expect(d11_team_table_stat6.matches_won).to eq 0 }
      specify { expect(d11_team_table_stat6.matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat6.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat6.goals_for).to eq 0 }
      specify { expect(d11_team_table_stat6.goals_against).to eq 2 }
      specify { expect(d11_team_table_stat6.goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat6.points).to eq 0 }

      specify { expect(d11_team_table_stat7.home_matches_played).to eq 0 }
      specify { expect(d11_team_table_stat7.home_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat7.home_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat7.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat7.home_goals_for).to eq 0 }
      specify { expect(d11_team_table_stat7.home_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat7.home_goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat7.home_points).to eq 0 }
      specify { expect(d11_team_table_stat7.away_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat7.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat7.away_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat7.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat7.away_goals_for).to eq 1 }
      specify { expect(d11_team_table_stat7.away_goals_against).to eq 3 }
      specify { expect(d11_team_table_stat7.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat7.away_points).to eq 1 }
      specify { expect(d11_team_table_stat7.matches_played).to eq 2 }
      specify { expect(d11_team_table_stat7.matches_won).to eq 0 }
      specify { expect(d11_team_table_stat7.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat7.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat7.goals_for).to eq 1 }
      specify { expect(d11_team_table_stat7.goals_against).to eq 3 }
      specify { expect(d11_team_table_stat7.goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat7.points).to eq 1 }

      specify { expect(d11_team_table_stat8.home_matches_played).to eq 1 }
      specify { expect(d11_team_table_stat8.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat8.home_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat8.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat8.home_goals_for).to eq 2 }
      specify { expect(d11_team_table_stat8.home_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat8.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat8.home_points).to eq 3 }
      specify { expect(d11_team_table_stat8.away_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat8.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat8.away_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat8.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat8.away_goals_for).to eq 1 }
      specify { expect(d11_team_table_stat8.away_goals_against).to eq 3 }
      specify { expect(d11_team_table_stat8.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat8.away_points).to eq 1 }
      specify { expect(d11_team_table_stat8.matches_played).to eq 3 }
      specify { expect(d11_team_table_stat8.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat8.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat8.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat8.goals_for).to eq 3 }
      specify { expect(d11_team_table_stat8.goals_against).to eq 3 }
      specify { expect(d11_team_table_stat8.goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat8.points).to eq 4 }

      specify { expect(d11_team_table_stat9.home_matches_played).to eq 1 }
      specify { expect(d11_team_table_stat9.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat9.home_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat9.home_matches_lost).to eq 0 }
      specify { expect(d11_team_table_stat9.home_goals_for).to eq 2 }
      specify { expect(d11_team_table_stat9.home_goals_against).to eq 0 }
      specify { expect(d11_team_table_stat9.home_goal_difference).to eq 2 }
      specify { expect(d11_team_table_stat9.home_points).to eq 3 }
      specify { expect(d11_team_table_stat9.away_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat9.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat9.away_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat9.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat9.away_goals_for).to eq 1 }
      specify { expect(d11_team_table_stat9.away_goals_against).to eq 3 }
      specify { expect(d11_team_table_stat9.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat9.away_points).to eq 1 }
      specify { expect(d11_team_table_stat9.matches_played).to eq 3 }
      specify { expect(d11_team_table_stat9.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat9.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat9.matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat9.goals_for).to eq 3 }
      specify { expect(d11_team_table_stat9.goals_against).to eq 3 }
      specify { expect(d11_team_table_stat9.goal_difference).to eq 0 }
      specify { expect(d11_team_table_stat9.points).to eq 4 }

      specify { expect(d11_team_table_stat10.home_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat10.home_matches_won).to eq 1 }
      specify { expect(d11_team_table_stat10.home_matches_drawn).to eq 0 }
      specify { expect(d11_team_table_stat10.home_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat10.home_goals_for).to eq 3 }
      specify { expect(d11_team_table_stat10.home_goals_against).to eq 2 }
      specify { expect(d11_team_table_stat10.home_goal_difference).to eq 1 }
      specify { expect(d11_team_table_stat10.home_points).to eq 3 }
      specify { expect(d11_team_table_stat10.away_matches_played).to eq 2 }
      specify { expect(d11_team_table_stat10.away_matches_won).to eq 0 }
      specify { expect(d11_team_table_stat10.away_matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat10.away_matches_lost).to eq 1 }
      specify { expect(d11_team_table_stat10.away_goals_for).to eq 1 }
      specify { expect(d11_team_table_stat10.away_goals_against).to eq 3 }
      specify { expect(d11_team_table_stat10.away_goal_difference).to eq (-2) }
      specify { expect(d11_team_table_stat10.away_points).to eq 1 }
      specify { expect(d11_team_table_stat10.matches_played).to eq 4 }
      specify { expect(d11_team_table_stat10.matches_won).to eq 1 }
      specify { expect(d11_team_table_stat10.matches_drawn).to eq 1 }
      specify { expect(d11_team_table_stat10.matches_lost).to eq 2 }
      specify { expect(d11_team_table_stat10.goals_for).to eq 4 }
      specify { expect(d11_team_table_stat10.goals_against).to eq 5 }
      specify { expect(d11_team_table_stat10.goal_difference).to eq (-1) }
      specify { expect(d11_team_table_stat10.points).to eq 4 }

      describe "for subset of season" do
        before do
          d11_match4.status = :finished
          d11_match4.save
          D11TeamTableStat.update_stats_from(d11_match4)
          d11_team_table_stat1.reload
          d11_team_table_stat2.reload
          d11_team_table_stat3.reload
          d11_team_table_stat4.reload
          d11_team_table_stat5.reload
          d11_team_table_stat6.reload
          d11_team_table_stat7.reload
          d11_team_table_stat8.reload
          d11_team_table_stat9.reload
          d11_team_table_stat10.reload
        end

        specify { expect(d11_team_table_stat1.home_matches_played).to eq 1 }
        specify { expect(d11_team_table_stat1.home_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat1.home_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat1.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat1.home_goals_for).to eq 2 }
        specify { expect(d11_team_table_stat1.home_goals_against).to eq 0 }
        specify { expect(d11_team_table_stat1.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat1.home_points).to eq 3 }
        specify { expect(d11_team_table_stat1.away_matches_played).to eq 0 }
        specify { expect(d11_team_table_stat1.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat1.away_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat1.away_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat1.away_goals_for).to eq 0 }
        specify { expect(d11_team_table_stat1.away_goals_against).to eq 0 }
        specify { expect(d11_team_table_stat1.away_goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat1.away_points).to eq 0 }
        specify { expect(d11_team_table_stat1.matches_played).to eq 1 }
        specify { expect(d11_team_table_stat1.matches_won).to eq 1 }
        specify { expect(d11_team_table_stat1.matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat1.matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat1.goals_for).to eq 2 }
        specify { expect(d11_team_table_stat1.goals_against).to eq 0 }
        specify { expect(d11_team_table_stat1.goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat1.points).to eq 3 }
  
        specify { expect(d11_team_table_stat2.home_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat2.home_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat2.home_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat2.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat2.home_goals_for).to eq 3 }
        specify { expect(d11_team_table_stat2.home_goals_against).to eq 1 }
        specify { expect(d11_team_table_stat2.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat2.home_points).to eq 4 }
        specify { expect(d11_team_table_stat2.away_matches_played).to eq 0 }
        specify { expect(d11_team_table_stat2.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat2.away_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat2.away_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat2.away_goals_for).to eq 0 }
        specify { expect(d11_team_table_stat2.away_goals_against).to eq 0 }
        specify { expect(d11_team_table_stat2.away_goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat2.away_points).to eq 0 }
        specify { expect(d11_team_table_stat2.matches_played).to eq 2 }
        specify { expect(d11_team_table_stat2.matches_won).to eq 1 }
        specify { expect(d11_team_table_stat2.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat2.matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat2.goals_for).to eq 3 }
        specify { expect(d11_team_table_stat2.goals_against).to eq 1 }
        specify { expect(d11_team_table_stat2.goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat2.points).to eq 4 }
        
        specify { expect(d11_team_table_stat3.home_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat3.home_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat3.home_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat3.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat3.home_goals_for).to eq 3 }
        specify { expect(d11_team_table_stat3.home_goals_against).to eq 1 }
        specify { expect(d11_team_table_stat3.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat3.home_points).to eq 4 }
        specify { expect(d11_team_table_stat3.away_matches_played).to eq 1 }
        specify { expect(d11_team_table_stat3.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat3.away_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat3.away_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat3.away_goals_for).to eq 0 }
        specify { expect(d11_team_table_stat3.away_goals_against).to eq 2 }
        specify { expect(d11_team_table_stat3.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat3.away_points).to eq 0 }
        specify { expect(d11_team_table_stat3.matches_played).to eq 3 }
        specify { expect(d11_team_table_stat3.matches_won).to eq 1 }
        specify { expect(d11_team_table_stat3.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat3.matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat3.goals_for).to eq 3 }
        specify { expect(d11_team_table_stat3.goals_against).to eq 3 }
        specify { expect(d11_team_table_stat3.goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat3.points).to eq 4 }

        specify { expect(d11_team_table_stat4.home_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat4.home_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat4.home_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat4.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat4.home_goals_for).to eq 3 }
        specify { expect(d11_team_table_stat4.home_goals_against).to eq 1 }
        specify { expect(d11_team_table_stat4.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat4.home_points).to eq 4 }
        specify { expect(d11_team_table_stat4.away_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat4.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat4.away_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat4.away_matches_lost).to eq 2 }
        specify { expect(d11_team_table_stat4.away_goals_for).to eq 2 }
        specify { expect(d11_team_table_stat4.away_goals_against).to eq 5 }
        specify { expect(d11_team_table_stat4.away_goal_difference).to eq (-3) }
        specify { expect(d11_team_table_stat4.away_points).to eq 0 }
        specify { expect(d11_team_table_stat4.matches_played).to eq 4 }
        specify { expect(d11_team_table_stat4.matches_won).to eq 1 }
        specify { expect(d11_team_table_stat4.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat4.matches_lost).to eq 2 }
        specify { expect(d11_team_table_stat4.goals_for).to eq 5 }
        specify { expect(d11_team_table_stat4.goals_against).to eq 6 }
        specify { expect(d11_team_table_stat4.goal_difference).to eq (-1) }
        specify { expect(d11_team_table_stat4.points).to eq 4 }

        specify { expect(d11_team_table_stat5.home_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat5.home_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat5.home_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat5.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat5.home_goals_for).to eq 3 }
        specify { expect(d11_team_table_stat5.home_goals_against).to eq 1 }
        specify { expect(d11_team_table_stat5.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat5.home_points).to eq 4 }
        specify { expect(d11_team_table_stat5.away_matches_played).to eq 3 }
        specify { expect(d11_team_table_stat5.away_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat5.away_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat5.away_matches_lost).to eq 2 }
        specify { expect(d11_team_table_stat5.away_goals_for).to eq 4 }
        specify { expect(d11_team_table_stat5.away_goals_against).to eq 6 }
        specify { expect(d11_team_table_stat5.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat5.away_points).to eq 3 }
        specify { expect(d11_team_table_stat5.matches_played).to eq 5 }
        specify { expect(d11_team_table_stat5.matches_won).to eq 2 }
        specify { expect(d11_team_table_stat5.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat5.matches_lost).to eq 2 }
        specify { expect(d11_team_table_stat5.goals_for).to eq 7 }
        specify { expect(d11_team_table_stat5.goals_against).to eq 7 }
        specify { expect(d11_team_table_stat5.goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat5.points).to eq 7 }

        specify { expect(d11_team_table_stat6.home_matches_played).to eq 0 }
        specify { expect(d11_team_table_stat6.home_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat6.home_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat6.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat6.home_goals_for).to eq 0 }
        specify { expect(d11_team_table_stat6.home_goals_against).to eq 0 }
        specify { expect(d11_team_table_stat6.home_goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat6.home_points).to eq 0 }
        specify { expect(d11_team_table_stat6.away_matches_played).to eq 1 }
        specify { expect(d11_team_table_stat6.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat6.away_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat6.away_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat6.away_goals_for).to eq 0 }
        specify { expect(d11_team_table_stat6.away_goals_against).to eq 2 }
        specify { expect(d11_team_table_stat6.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat6.away_points).to eq 0 }
        specify { expect(d11_team_table_stat6.matches_played).to eq 1 }
        specify { expect(d11_team_table_stat6.matches_won).to eq 0 }
        specify { expect(d11_team_table_stat6.matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat6.matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat6.goals_for).to eq 0 }
        specify { expect(d11_team_table_stat6.goals_against).to eq 2 }
        specify { expect(d11_team_table_stat6.goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat6.points).to eq 0 }
  
        specify { expect(d11_team_table_stat7.home_matches_played).to eq 0 }
        specify { expect(d11_team_table_stat7.home_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat7.home_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat7.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat7.home_goals_for).to eq 0 }
        specify { expect(d11_team_table_stat7.home_goals_against).to eq 0 }
        specify { expect(d11_team_table_stat7.home_goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat7.home_points).to eq 0 }
        specify { expect(d11_team_table_stat7.away_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat7.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat7.away_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat7.away_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat7.away_goals_for).to eq 1 }
        specify { expect(d11_team_table_stat7.away_goals_against).to eq 3 }
        specify { expect(d11_team_table_stat7.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat7.away_points).to eq 1 }
        specify { expect(d11_team_table_stat7.matches_played).to eq 2 }
        specify { expect(d11_team_table_stat7.matches_won).to eq 0 }
        specify { expect(d11_team_table_stat7.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat7.matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat7.goals_for).to eq 1 }
        specify { expect(d11_team_table_stat7.goals_against).to eq 3 }
        specify { expect(d11_team_table_stat7.goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat7.points).to eq 1 }
  
        specify { expect(d11_team_table_stat8.home_matches_played).to eq 1 }
        specify { expect(d11_team_table_stat8.home_matches_won).to eq 1 }
        specify { expect(d11_team_table_stat8.home_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat8.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat8.home_goals_for).to eq 2 }
        specify { expect(d11_team_table_stat8.home_goals_against).to eq 0 }
        specify { expect(d11_team_table_stat8.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat8.home_points).to eq 3 }
        specify { expect(d11_team_table_stat8.away_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat8.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat8.away_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat8.away_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat8.away_goals_for).to eq 1 }
        specify { expect(d11_team_table_stat8.away_goals_against).to eq 3 }
        specify { expect(d11_team_table_stat8.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat8.away_points).to eq 1 }
        specify { expect(d11_team_table_stat8.matches_played).to eq 3 }
        specify { expect(d11_team_table_stat8.matches_won).to eq 1 }
        specify { expect(d11_team_table_stat8.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat8.matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat8.goals_for).to eq 3 }
        specify { expect(d11_team_table_stat8.goals_against).to eq 3 }
        specify { expect(d11_team_table_stat8.goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat8.points).to eq 4 }

        specify { expect(d11_team_table_stat9.home_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat9.home_matches_won).to eq 2 }
        specify { expect(d11_team_table_stat9.home_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat9.home_matches_lost).to eq 0 }
        specify { expect(d11_team_table_stat9.home_goals_for).to eq 5 }
        specify { expect(d11_team_table_stat9.home_goals_against).to eq 2 }
        specify { expect(d11_team_table_stat9.home_goal_difference).to eq 3 }
        specify { expect(d11_team_table_stat9.home_points).to eq 6 }
        specify { expect(d11_team_table_stat9.away_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat9.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat9.away_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat9.away_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat9.away_goals_for).to eq 1 }
        specify { expect(d11_team_table_stat9.away_goals_against).to eq 3 }
        specify { expect(d11_team_table_stat9.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat9.away_points).to eq 1 }
        specify { expect(d11_team_table_stat9.matches_played).to eq 4 }
        specify { expect(d11_team_table_stat9.matches_won).to eq 2 }
        specify { expect(d11_team_table_stat9.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat9.matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat9.goals_for).to eq 6 }
        specify { expect(d11_team_table_stat9.goals_against).to eq 5 }
        specify { expect(d11_team_table_stat9.goal_difference).to eq 1 }
        specify { expect(d11_team_table_stat9.points).to eq 7 }

        specify { expect(d11_team_table_stat10.home_matches_played).to eq 3 }
        specify { expect(d11_team_table_stat10.home_matches_won).to eq 2 }
        specify { expect(d11_team_table_stat10.home_matches_drawn).to eq 0 }
        specify { expect(d11_team_table_stat10.home_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat10.home_goals_for).to eq 6 }
        specify { expect(d11_team_table_stat10.home_goals_against).to eq 4 }
        specify { expect(d11_team_table_stat10.home_goal_difference).to eq 2 }
        specify { expect(d11_team_table_stat10.home_points).to eq 6 }
        specify { expect(d11_team_table_stat10.away_matches_played).to eq 2 }
        specify { expect(d11_team_table_stat10.away_matches_won).to eq 0 }
        specify { expect(d11_team_table_stat10.away_matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat10.away_matches_lost).to eq 1 }
        specify { expect(d11_team_table_stat10.away_goals_for).to eq 1 }
        specify { expect(d11_team_table_stat10.away_goals_against).to eq 3 }
        specify { expect(d11_team_table_stat10.away_goal_difference).to eq (-2) }
        specify { expect(d11_team_table_stat10.away_points).to eq 1 }
        specify { expect(d11_team_table_stat10.matches_played).to eq 5 }
        specify { expect(d11_team_table_stat10.matches_won).to eq 2 }
        specify { expect(d11_team_table_stat10.matches_drawn).to eq 1 }
        specify { expect(d11_team_table_stat10.matches_lost).to eq 2 }
        specify { expect(d11_team_table_stat10.goals_for).to eq 7 }
        specify { expect(d11_team_table_stat10.goals_against).to eq 7 }
        specify { expect(d11_team_table_stat10.goal_difference).to eq 0 }
        specify { expect(d11_team_table_stat10.points).to eq 7 }        
      end
    end
  end

  describe '.update_rankings' do
    before { D11TeamTableStat.destroy_all }
    
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day) }
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day, home_matches_won: 2, away_matches_drawn: 1) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day, home_matches_won: 1, home_matches_drawn: 1, away_matches_won: 1, away_matches_drawn: 1) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day, away_matches_won: 2) }
    
    before do
      D11TeamTableStat.update_rankings(d11_match_day)
      d11_team_table_stat1.reload
      d11_team_table_stat2.reload
      d11_team_table_stat3.reload
    end
    
    specify { expect(d11_team_table_stat1.ranking).to eq 2 }
    specify { expect(d11_team_table_stat2.ranking).to eq 1 }
    specify { expect(d11_team_table_stat3.ranking).to eq 3 }
    
    specify { expect(d11_team_table_stat1.home_ranking).to eq 1 }
    specify { expect(d11_team_table_stat2.home_ranking).to eq 2 }
    specify { expect(d11_team_table_stat3.home_ranking).to eq 3 }

    specify { expect(d11_team_table_stat1.away_ranking).to eq 3 }
    specify { expect(d11_team_table_stat2.away_ranking).to eq 2 }
    specify { expect(d11_team_table_stat3.away_ranking).to eq 1 }    
  end

  describe '.update_rankings_from' do
    before { D11TeamTableStat.destroy_all }
    
    let!(:d11_league) { FactoryGirl.create(:d11_league) }
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, date: Date.today - 1.day, match_day_number: 1) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, date: Date.today, match_day_number: 2) }
    let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, date: Date.today + 1.day, match_day_number: 3) }
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day1) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day2) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day3) }
    
    before do
      D11TeamTableStat.update_rankings_from(d11_match_day2)
      d11_team_table_stat1.reload
      d11_team_table_stat2.reload
      d11_team_table_stat3.reload
    end
    
    specify { expect(d11_team_table_stat1.ranking).to eq 0 }
    specify { expect(d11_team_table_stat2.ranking).to eq 1 }
    specify { expect(d11_team_table_stat3.ranking).to eq 1 }
    
    specify { expect(d11_team_table_stat1.home_ranking).to eq 0 }
    specify { expect(d11_team_table_stat2.home_ranking).to eq 1 }
    specify { expect(d11_team_table_stat3.home_ranking).to eq 1 }

    specify { expect(d11_team_table_stat1.away_ranking).to eq 0 }
    specify { expect(d11_team_table_stat2.away_ranking).to eq 1 }
    specify { expect(d11_team_table_stat3.away_ranking).to eq 1 }    
  end

  context "when d11_team is nil" do
    before { @d11_team_table_stat.d11_team = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when d11_league is nil" do
    before { @d11_team_table_stat.d11_league = nil }
    it { is_expected.not_to be_valid }
  end 

  context "when d11_match_day is nil" do
    before { @d11_team_table_stat.d11_match_day = nil }
    it { is_expected.not_to be_valid }
  end 

  describe "form_points" do
    let!(:d11_team1) { FactoryGirl.create(:d11_team) }
    let!(:d11_team2) { FactoryGirl.create(:d11_team) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day) }
    let!(:d11_match1) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day, status: :finished, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 1, away_team_points: 0) }
    let!(:d11_match2) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day, status: :finished, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 0, away_team_points: 1) }
    let!(:d11_match3) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day, status: :finished, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 0, away_team_points: 0) }
    let!(:d11_match4) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day, status: :finished, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 1, away_team_points: 0) }
    let!(:d11_match5) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day, status: :finished, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 1, away_team_points: 0) }
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team1, d11_match_day: d11_match_day)}
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_team: d11_team2, d11_match_day: d11_match_day)}
  
    specify { expect(d11_team_table_stat1.form_points).to eq 10 }
    specify { expect(d11_team_table_stat2.form_points).to eq 4 }
  end

  describe "default scope order" do
    before { D11TeamTableStat.destroy_all }
    
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, ranking: 3) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, ranking: 4) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, ranking: 1) }
    let!(:d11_team_table_stat4) { FactoryGirl.create(:d11_team_table_stat, ranking: 2) }
    
    specify { expect(D11TeamTableStat.all).to eq [ d11_team_table_stat3, d11_team_table_stat4, d11_team_table_stat1, d11_team_table_stat2 ] }
  end

  describe "combined_ordered and home_ordered scope order" do
    before { D11TeamTableStat.destroy_all }
    let!(:d11_team1) { FactoryGirl.create(:d11_team, name: "B") }
    let!(:d11_team2) { FactoryGirl.create(:d11_team, name: "A") }
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 2) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 1) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 4) }
    let!(:d11_team_table_stat4) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 3, home_goals_for: 1) }
    let!(:d11_team_table_stat5) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 3, home_goals_for: 2, home_goals_against: 1) }
    let!(:d11_team_table_stat6) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 3, home_goals_for: 2, home_goals_against: 2, d11_team: d11_team1) }
    let!(:d11_team_table_stat7) { FactoryGirl.create(:d11_team_table_stat, home_matches_won: 3, home_goals_for: 2, home_goals_against: 2, d11_team: d11_team2) }
    
    specify { expect(D11TeamTableStat.combined_ordered).to eq [ d11_team_table_stat3, d11_team_table_stat7, d11_team_table_stat6, d11_team_table_stat5, d11_team_table_stat4, d11_team_table_stat1, d11_team_table_stat2 ] }
    specify { expect(D11TeamTableStat.home_ordered).to eq [ d11_team_table_stat3, d11_team_table_stat7, d11_team_table_stat6, d11_team_table_stat5, d11_team_table_stat4, d11_team_table_stat1, d11_team_table_stat2 ] }
  end


  describe "away_ordered scope order" do
    before { D11TeamTableStat.destroy_all }
    let!(:d11_team1) { FactoryGirl.create(:d11_team, name: "B") }
    let!(:d11_team2) { FactoryGirl.create(:d11_team, name: "A") }
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 2) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 1) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 4) }
    let!(:d11_team_table_stat4) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 3, away_goals_for: 1) }
    let!(:d11_team_table_stat5) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 3, away_goals_for: 2, away_goals_against: 1) }
    let!(:d11_team_table_stat6) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 3, away_goals_for: 2, away_goals_against: 2, d11_team: d11_team1) }
    let!(:d11_team_table_stat7) { FactoryGirl.create(:d11_team_table_stat, away_matches_won: 3, away_goals_for: 2, away_goals_against: 2, d11_team: d11_team2) }
    
    specify { expect(D11TeamTableStat.away_ordered).to eq [ d11_team_table_stat3, d11_team_table_stat7, d11_team_table_stat6, d11_team_table_stat5, d11_team_table_stat4, d11_team_table_stat1, d11_team_table_stat2 ] }
  end

  describe "date_ordered scope order" do
    before { D11TeamTableStat.destroy_all }
    
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, date: Date.today - 1.day, match_day_number: 1) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, date: Date.today - 1.day, match_day_number: 2) }
    let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, date: Date.today, match_day_number: 1) }
    let!(:d11_match_day4) { FactoryGirl.create(:d11_match_day, date: Date.today, match_day_number: 2) }
    let!(:d11_team_table_stat1) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day3) }
    let!(:d11_team_table_stat2) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day4) }
    let!(:d11_team_table_stat3) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day1) }
    let!(:d11_team_table_stat4) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: d11_match_day2) }
    
    specify { expect(D11TeamTableStat.date_ordered).to eq [ d11_team_table_stat3, d11_team_table_stat4, d11_team_table_stat1, d11_team_table_stat2 ] }

  end

end
