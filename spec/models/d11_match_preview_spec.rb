require 'rails_helper'

describe D11MatchPreview, type: :model do
  let!(:season) { FactoryGirl.create(:season) }
  let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
  let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
  let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today - 4.day, match_day_number: 1) }
  let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today - 3.day, match_day_number: 2) }
  let!(:match_day3) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today - 2.day, match_day_number: 3) }
  let!(:match_day4) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today - 1.day, match_day_number: 4) }
  let!(:match_day5) { FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today + 1.day, match_day_number: 5) }
  let!(:match1) { FactoryGirl.create(:match, match_day: match_day1) }
  let!(:match2) { FactoryGirl.create(:match, match_day: match_day2) }
  let!(:match3) { FactoryGirl.create(:match, match_day: match_day3) }
  let!(:match4) { FactoryGirl.create(:match, match_day: match_day4) }
  let!(:match5) { FactoryGirl.create(:match, match_day: match_day5) }  
  let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day1, match_day_number: 1, date: Date.today - 4.day) }
  let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day2, match_day_number: 2, date: Date.today - 3.day) }
  let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day3, match_day_number: 3, date: Date.today - 2.day) }
  let!(:d11_match_day4) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day4, match_day_number: 4, date: Date.today - 1.day) }
  let!(:d11_match_day5) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day5, match_day_number: 6, date: Date.today + 1.day) }  
  let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 5, date: Date.today) }
  let!(:d11_match) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day) }
  let(:d11_team1) { d11_match.home_d11_team }
  let(:d11_team2) { d11_match.away_d11_team }  
  let!(:d11_match1) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day1, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 1, away_team_points: 5, status: 2) }
  let!(:d11_match2) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day2, home_d11_team: d11_team2, away_d11_team: d11_team1, home_team_points: 1, away_team_points: 5, status: 2) }
  let!(:d11_match3) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day3, home_d11_team: d11_team1, away_d11_team: d11_team2, home_team_points: 5, away_team_points: 5, status: 2) }
  let!(:d11_match4) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day4, home_d11_team: d11_team2, away_d11_team: d11_team1, home_team_points: 10, away_team_points: 5, status: 2) }
  let!(:d11_match5) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day5, home_d11_team: d11_team1, away_d11_team: d11_team2, status: 0) }
  let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, match: match1, d11_team: d11_team1, yellow_card_time: 10) }
  let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, match: match2, d11_team: d11_team2, yellow_card_time: 10) }
  let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, match: match3, d11_team: d11_team2, yellow_card_time: 10) }
  let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, match: match3, d11_team: d11_team2, yellow_card_time: 10) }  
  let!(:player_match_stat5) { FactoryGirl.create(:player_match_stat, match: match1, d11_team: d11_team1, red_card_time: 10) }
  let!(:player_match_stat6) { FactoryGirl.create(:player_match_stat, match: match2, d11_team: d11_team2, red_card_time: 10) }
  let!(:player_match_stat7) { FactoryGirl.create(:player_match_stat, match: match3, d11_team: d11_team2, red_card_time: 10) }
    
  before { @d11_match_preview = D11MatchPreview.new(d11_match: d11_match) }
  
  subject { @d11_match_preview }
 
  it { is_expected.to respond_to(:d11_match) }
  
  it_should_behave_like "preview" 
  
  describe '#d11_match' do
    specify { expect(@d11_match_preview.d11_match).to eq d11_match } 
  end 

  describe '#previous_meetings' do
    specify { expect(@d11_match_preview.previous_meetings).to eq [ d11_match4, d11_match3, d11_match2, d11_match1 ] } 
  end 
    
end
