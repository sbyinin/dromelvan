require 'rails_helper'

describe PlayerSeasonStat, type: :model do  
  let(:player) { FactoryGirl.create(:player) }
  let(:season) { FactoryGirl.create(:season) }
  
  before { @player_season_stat = FactoryGirl.create(:player_season_stat, player: player, season: season) }
  
  subject { @player_season_stat }

  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:ranking) }

  it { is_expected.to be_valid }

  describe '#player' do
    subject { @player_season_stat.player }
    it { is_expected.to eq player }
  end

  describe '#season' do
    subject { @player_season_stat.season }
    it { is_expected.to eq season }
  end

  describe '#ranking' do
    subject { @player_season_stat.ranking }
    it { is_expected.to eq 0 }
  end
  
  describe "#player_match_stats" do
    before { PlayerMatchStat.destroy_all }
    
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
    let!(:player) { FactoryGirl.create(:player) }
    let!(:player_match_stat) { FactoryGirl.create(:player_match_stat, player: player, match: match) }
    let!(:player_season_stat) { FactoryGirl.create(:player_season_stat, player: player, season: season) }
    
    specify { expect(player_season_stat.player_match_stats.to_a).to eq [ player_match_stat ] }               
  end
  
  describe "#summarize_stats" do    
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
    let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match2) { FactoryGirl.create(:match, match_day: match_day2) }
    let!(:match_day3) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match3) { FactoryGirl.create(:match, match_day: match_day3) }
    let!(:match_day4) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match4) { FactoryGirl.create(:match, match_day: match_day4) }            
    let!(:player) { FactoryGirl.create(:player) }
    
    context "for defender" do
      let!(:position) { FactoryGirl.create(:position, defender: true) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player, match: match, position: position, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player, match: match2, position: position, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player, match: match3, position: position, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, player: player, match: match4, position: position, lineup: :did_not_participate) }
      let!(:player_season_stats) { FactoryGirl.create(:player_season_stat, player: player, season: season) }    
      
      specify { expect(player_season_stats.goals).to eq 3 }
      specify { expect(player_season_stats.goal_assists).to eq 3 }
      specify { expect(player_season_stats.own_goals).to eq 3 }
      specify { expect(player_season_stats.goals_conceded).to eq 3 }
      specify { expect(player_season_stats.clean_sheets).to eq 1 }
      specify { expect(player_season_stats.rating).to eq 700 }
      specify { expect(player_season_stats.points).to eq 9 }                    
      specify { expect(player_season_stats.yellow_cards).to eq 2 }
      specify { expect(player_season_stats.red_cards).to eq 2 }
      specify { expect(player_season_stats.man_of_the_match).to eq 1 }
      specify { expect(player_season_stats.shared_man_of_the_match).to eq 1 }
      specify { expect(player_season_stats.games_started).to eq 2 }
      specify { expect(player_season_stats.games_substitute).to eq 1 }
      specify { expect(player_season_stats.games_did_not_participate).to eq 1 }
      specify { expect(player_season_stats.substitutions_on).to eq 1 }
      specify { expect(player_season_stats.substitutions_off).to eq 1 }
      specify { expect(player_season_stats.minutes_played).to eq 265 }
    end
    
    context "for non-defender" do
      let!(:position) { FactoryGirl.create(:position, defender: false) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player, match: match, position: position, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player, match: match2, position: position, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player, match: match3, position: position, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, player: player, match: match4, position: position, lineup: :did_not_participate) }
      let!(:player_season_stats) { FactoryGirl.create(:player_season_stat, player: player, season: season) }    
      
      specify { expect(player_season_stats.goals).to eq 3 }
      specify { expect(player_season_stats.goal_assists).to eq 3 }
      specify { expect(player_season_stats.own_goals).to eq 3 }
      specify { expect(player_season_stats.goals_conceded).to eq 0 }
      specify { expect(player_season_stats.clean_sheets).to eq 0 }
      specify { expect(player_season_stats.rating).to eq 700 }
      specify { expect(player_season_stats.points).to eq 7 }                    
      specify { expect(player_season_stats.yellow_cards).to eq 2 }
      specify { expect(player_season_stats.red_cards).to eq 2 }
      specify { expect(player_season_stats.man_of_the_match).to eq 1 }
      specify { expect(player_season_stats.shared_man_of_the_match).to eq 1 }
      specify { expect(player_season_stats.games_started).to eq 2 }
      specify { expect(player_season_stats.games_substitute).to eq 1 }
      specify { expect(player_season_stats.games_did_not_participate).to eq 1 }
      specify { expect(player_season_stats.substitutions_on).to eq 1 }
      specify { expect(player_season_stats.substitutions_off).to eq 1 }
      specify { expect(player_season_stats.minutes_played).to eq 265 }
    end
    
  end
  
  describe ".update_rankings" do

    before do
      PlayerSeasonStat.destroy_all
    end
    
    describe "after destroy_all" do
      let!(:season) { FactoryGirl.create(:season) }
      let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
      let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
      let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
      let!(:player1) { FactoryGirl.create(:player) }
      let!(:player2) { FactoryGirl.create(:player) }
      let!(:player3) { FactoryGirl.create(:player) }
      let!(:position) { FactoryGirl.create(:position) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player1, match: match, lineup: :starting_lineup, position: position) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player2, match: match, lineup: :starting_lineup, position: position, goals: 1) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player3, match: match, lineup: :starting_lineup, position: position, goals: 2) }
      let!(:player_season_stats1) { FactoryGirl.create(:player_season_stat, player: player1, season: season) }
      let!(:player_season_stats2) { FactoryGirl.create(:player_season_stat, player: player2, season: season) }
      let!(:player_season_stats3) { FactoryGirl.create(:player_season_stat, player: player3, season: season) }    
      
      before do
        PlayerSeasonStat.update_rankings(season)
      end
      
      specify { expect(player_season_stats1.reload.ranking).to eq 3 }
      specify { expect(player_season_stats2.reload.ranking).to eq 2 }
      specify { expect(player_season_stats3.reload.ranking).to eq 1 }
    end
  end
  
  it_should_behave_like "player stats summary"

  context "when player is nil" do
    before { @player_season_stat.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when season is nil" do
    before { @player_season_stat.season = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when ranking is nil" do
    before { @player_season_stat.ranking = nil }
    it { is_expected.not_to be_valid }
  end

  context "when ranking is invalid" do
    before { @player_season_stat.ranking = -1 }
    it { is_expected.not_to be_valid }
  end
  
end
