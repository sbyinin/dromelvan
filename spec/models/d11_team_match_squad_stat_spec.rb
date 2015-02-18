require 'rails_helper'

describe D11TeamMatchSquadStat, type: :model do
  let!(:season) { FactoryGirl.create(:season) }
  let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
  let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
  let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1) }
  let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 1) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }  
  let(:d11_match) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day) }
  
  before { @d11_team_match_squad_stat = FactoryGirl.create(:d11_team_match_squad_stat, d11_team: d11_team, d11_match: d11_match) }
  
  subject { @d11_team_match_squad_stat }

  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:d11_match) }

  it { is_expected.to be_valid }

  describe '#d11_team' do
    subject { @d11_team_match_squad_stat.d11_team }
    it { is_expected.to eq d11_team }
  end

  describe '#d11_match' do
    subject { @d11_team_match_squad_stat.d11_match }
    it { is_expected.to eq d11_match }
  end

  describe "#summarize_stats" do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
    let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day,  match_day_number: 1) }
    let!(:d11_match) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day) }
        
    context "for defenders" do
      let!(:position) { FactoryGirl.create(:position, defender: true) }
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, position: position, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, position: position, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, position: position, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, position: position, lineup: :did_not_participate) }
      let!(:d11_team_match_squad_stat) { FactoryGirl.create(:d11_team_match_squad_stat, d11_team: d11_match.home_d11_team, d11_match: d11_match) }
            
      specify { expect(d11_team_match_squad_stat.goals).to eq 3 }
      specify { expect(d11_team_match_squad_stat.goal_assists).to eq 3 }
      specify { expect(d11_team_match_squad_stat.own_goals).to eq 3 }
      specify { expect(d11_team_match_squad_stat.goals_conceded).to eq 3 }
      specify { expect(d11_team_match_squad_stat.clean_sheets).to eq 1 }
      specify { expect(d11_team_match_squad_stat.rating).to eq 700 }
      specify { expect(d11_team_match_squad_stat.points).to eq 9 }                    
      specify { expect(d11_team_match_squad_stat.yellow_cards).to eq 2 }
      specify { expect(d11_team_match_squad_stat.red_cards).to eq 2 }
      specify { expect(d11_team_match_squad_stat.man_of_the_match).to eq 1 }
      specify { expect(d11_team_match_squad_stat.shared_man_of_the_match).to eq 1 }
      specify { expect(d11_team_match_squad_stat.games_started).to eq 2 }
      specify { expect(d11_team_match_squad_stat.games_substitute).to eq 1 }
      specify { expect(d11_team_match_squad_stat.games_did_not_participate).to eq 1 }
      specify { expect(d11_team_match_squad_stat.substitutions_on).to eq 1 }
      specify { expect(d11_team_match_squad_stat.substitutions_off).to eq 1 }
      specify { expect(d11_team_match_squad_stat.minutes_played).to eq 265 }
    end
    
    context "for non-defenders" do
      let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, lineup: :starting_lineup, goals: 1, goal_assists: 1, own_goals: 1, goals_conceded: 1, yellow_card_time: 40, red_card_time: 80, man_of_the_match: true, rating: 700, substitution_off_time: 90 ) }
      let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, lineup: :substitute, goals: 2, goal_assists: 2, own_goals: 2, goals_conceded: 2, yellow_card_time: 40, red_card_time: 80, shared_man_of_the_match: true, rating: 800, substitution_on_time: 5) }
      let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, lineup: :starting_lineup, goals_conceded: 0, rating: 600) }      
      let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, d11_team: d11_match.home_d11_team, match: match, lineup: :did_not_participate) }
      let!(:d11_team_match_squad_stat) { FactoryGirl.create(:d11_team_match_squad_stat, d11_team: d11_match.home_d11_team, d11_match: d11_match) }
      
      specify { expect(d11_team_match_squad_stat.goals).to eq 3 }
      specify { expect(d11_team_match_squad_stat.goal_assists).to eq 3 }
      specify { expect(d11_team_match_squad_stat.own_goals).to eq 3 }
      specify { expect(d11_team_match_squad_stat.goals_conceded).to eq 0 }
      specify { expect(d11_team_match_squad_stat.clean_sheets).to eq 0 }
      specify { expect(d11_team_match_squad_stat.rating).to eq 700 }
      specify { expect(d11_team_match_squad_stat.points).to eq 7 }                    
      specify { expect(d11_team_match_squad_stat.yellow_cards).to eq 2 }
      specify { expect(d11_team_match_squad_stat.red_cards).to eq 2 }
      specify { expect(d11_team_match_squad_stat.man_of_the_match).to eq 1 }
      specify { expect(d11_team_match_squad_stat.shared_man_of_the_match).to eq 1 }
      specify { expect(d11_team_match_squad_stat.games_started).to eq 2 }
      specify { expect(d11_team_match_squad_stat.games_substitute).to eq 1 }
      specify { expect(d11_team_match_squad_stat.games_did_not_participate).to eq 1 }
      specify { expect(d11_team_match_squad_stat.substitutions_on).to eq 1 }
      specify { expect(d11_team_match_squad_stat.substitutions_off).to eq 1 }
      specify { expect(d11_team_match_squad_stat.minutes_played).to eq 265 }      
    end
  end

  it_should_behave_like "player stats summary"

  context "when d11_team is nil" do
    before { @d11_team_match_squad_stat.d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_match is nil" do
    before { @d11_team_match_squad_stat.d11_match = nil }
    it { is_expected.not_to be_valid }
  end

  context "when team_goals is nil" do
    before { @d11_team_match_squad_stat.team_goals = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when team_goals is invalid" do
    before { @d11_team_match_squad_stat.team_goals = -1 }
    it { is_expected.not_to be_valid }
  end

end
