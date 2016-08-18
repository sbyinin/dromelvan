require 'rails_helper'

describe PlayerCareerStat, type: :model do  
  let(:player) { FactoryGirl.create(:player) }
  
  before { @player_career_stat = FactoryGirl.create(:player_career_stat, player: player) }
  
  subject { @player_career_stat }

  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:ranking) }
  it { is_expected.to respond_to(:seasons) }
  it { is_expected.to respond_to(:points_per_season) }
  it { is_expected.to respond_to(:points_per_season_s) }

  it { is_expected.to be_valid }

  describe '#player' do
    subject { @player_career_stat.player }
    it { is_expected.to eq player }
  end

  describe '#ranking' do
    subject { @player_career_stat.ranking }
    it { is_expected.to eq 0 }
  end
  
  describe '#seasons' do
    subject { @player_career_stat.seasons }
    it { is_expected.to eq 0 }
  end

  describe '#points_per_season' do
    subject { @player_career_stat.points_per_season }
    it { is_expected.to eq 0 }
  end
  
  describe '#points_per_season_s' do
    specify { expect(subject.points_per_season_s).to eq '0.00' }
    
    context 'when points_per_season > 0' do
      before { subject.points_per_season = 123 }
      
      specify { expect(subject.points_per_season_s).to eq '1.23' }
    end    
  end
  
  describe "#player_match_stats" do
    before { PlayerMatchStat.destroy_all }
    
    let!(:player1) { FactoryGirl.create(:player) }
    let!(:player2) { FactoryGirl.create(:player) }
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player1) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player1) }
    let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player2) }
    let!(:player_career_stat) { FactoryGirl.create(:player_career_stat, player: player1) }
    
    specify { expect(player_career_stat.player_match_stats.to_a).to eq [ player_match_stat1, player_match_stat2 ] }               
  end
    
  describe "#summarize_stats" do    
    let!(:player) { FactoryGirl.create(:player) }
    
    context "for defender" do
      let!(:position) { FactoryGirl.create(:position, defender: true) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :did_not_participate) }
      let!(:player_career_stats) { FactoryGirl.create(:player_career_stat, player: player) }    
      
      specify { expect(player_career_stats.goals).to eq 3 }
      specify { expect(player_career_stats.goal_assists).to eq 3 }
      specify { expect(player_career_stats.own_goals).to eq 3 }
      specify { expect(player_career_stats.goals_conceded).to eq 3 }
      specify { expect(player_career_stats.clean_sheets).to eq 1 }
      specify { expect(player_career_stats.rating).to eq 700 }
      specify { expect(player_career_stats.points).to eq 10 }                    
      specify { expect(player_career_stats.yellow_cards).to eq 2 }
      specify { expect(player_career_stats.red_cards).to eq 2 }
      specify { expect(player_career_stats.man_of_the_match).to eq 1 }
      specify { expect(player_career_stats.shared_man_of_the_match).to eq 1 }
      specify { expect(player_career_stats.games_started).to eq 2 }
      specify { expect(player_career_stats.games_substitute).to eq 1 }
      specify { expect(player_career_stats.games_did_not_participate).to eq 1 }
      specify { expect(player_career_stats.substitutions_on).to eq 1 }
      specify { expect(player_career_stats.substitutions_off).to eq 1 }
      specify { expect(player_career_stats.minutes_played).to eq 265 }
    end
    
    context "for non-defender" do
      let!(:position) { FactoryGirl.create(:position, defender: false) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, player: player, position: position, lineup: :did_not_participate) }
      let!(:player_career_stats) { FactoryGirl.create(:player_career_stat, player: player) }    
      
      specify { expect(player_career_stats.goals).to eq 3 }
      specify { expect(player_career_stats.goal_assists).to eq 3 }
      specify { expect(player_career_stats.own_goals).to eq 3 }
      specify { expect(player_career_stats.goals_conceded).to eq 0 }
      specify { expect(player_career_stats.clean_sheets).to eq 0 }
      specify { expect(player_career_stats.rating).to eq 700 }
      specify { expect(player_career_stats.points).to eq 7 }                    
      specify { expect(player_career_stats.yellow_cards).to eq 2 }
      specify { expect(player_career_stats.red_cards).to eq 2 }
      specify { expect(player_career_stats.man_of_the_match).to eq 1 }
      specify { expect(player_career_stats.shared_man_of_the_match).to eq 1 }
      specify { expect(player_career_stats.games_started).to eq 2 }
      specify { expect(player_career_stats.games_substitute).to eq 1 }
      specify { expect(player_career_stats.games_did_not_participate).to eq 1 }
      specify { expect(player_career_stats.substitutions_on).to eq 1 }
      specify { expect(player_career_stats.substitutions_off).to eq 1 }
      specify { expect(player_career_stats.minutes_played).to eq 265 }
    end
    
  end

  describe ".by_player" do
    let!(:player) { FactoryGirl.create(:player) }
    
    specify { expect(PlayerCareerStat.by_player(player)).not_to be_nil }
    specify { expect(PlayerCareerStat.by_player(player).player).to eq player }               
  end
  
  describe ".update_rankings" do

    before do
      PlayerCareerStat.destroy_all
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
      #let!(:player_career_stats1) { FactoryGirl.create(:player_career_stat, player: player1) }
      #let!(:player_career_stats2) { FactoryGirl.create(:player_career_stat, player: player2) }
      #let!(:player_career_stats3) { FactoryGirl.create(:player_career_stat, player: player3) }    
      
      before do
        PlayerCareerStat.all.each do |player_career_stat|
          player_career_stat.save
        end
        PlayerCareerStat.update_rankings
      end
      
      specify { expect(PlayerCareerStat.where(player: player1).first.reload.ranking).to eq 3 }
      specify { expect(PlayerCareerStat.where(player: player2).first.reload.ranking).to eq 2 }
      specify { expect(PlayerCareerStat.where(player: player3).first.reload.ranking).to eq 1 }
    end
  end  
  
  it_should_behave_like "player stats summary"

  context "when player is nil" do
    before { @player_career_stat.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when ranking is nil" do
    before { @player_career_stat.ranking = nil }
    it { is_expected.not_to be_valid }
  end

  context "when ranking is invalid" do
    before { @player_career_stat.ranking = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when seasons is nil" do
    before { @player_career_stat.seasons = nil }
    it { is_expected.to be_valid }
  end

  context "when seasons is invalid" do
    before { @player_career_stat.seasons = -1 }
    it { is_expected.to be_valid }
  end

  context "when points_per_season is nil" do
    before { @player_career_stat.points_per_season = nil }
    it { is_expected.to be_valid }
  end
  
end
