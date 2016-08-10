require 'rails_helper'

describe MatchPreview, type: :model do
  let(:match) { FactoryGirl.create(:match) }
  let(:team1) { match.home_team }
  let(:team2) { match.away_team }
  let!(:match1) { FactoryGirl.create(:match, home_team: team1, away_team: team2, home_team_goals: 1, away_team_goals: 2, datetime: DateTime.now - 4.day, status: 2) }
  let!(:goal1) { FactoryGirl.create(:goal, match: match1, team: team1) }
  let!(:goal2) { FactoryGirl.create(:goal, match: match1, team: team2) }
  let!(:goal3) { FactoryGirl.create(:goal, match: match1, team: team2) }
  let!(:match2) { FactoryGirl.create(:match, home_team: team2, away_team: team1, home_team_goals: 1, away_team_goals: 2, datetime: DateTime.now - 3.day, status: 2) }
  let!(:goal4) { FactoryGirl.create(:goal, match: match2, team: team2) }
  let!(:goal5) { FactoryGirl.create(:goal, match: match2, team: team1) }
  let!(:goal6) { FactoryGirl.create(:goal, match: match2, team: team1) }  
  let!(:match3) { FactoryGirl.create(:match, home_team: team1, away_team: team2, home_team_goals: 2, away_team_goals: 2, datetime: DateTime.now - 2.day, status: 2) }
  let!(:goal7) { FactoryGirl.create(:goal, match: match3, team: team1) }    
  let!(:goal8) { FactoryGirl.create(:goal, match: match3, team: team1) }
  let!(:goal9) { FactoryGirl.create(:goal, match: match3, team: team2) }
  let!(:goal10) { FactoryGirl.create(:goal, match: match3, team: team2) }    
  let!(:match4) { FactoryGirl.create(:match, home_team: team2, away_team: team1, home_team_goals: 3, away_team_goals: 2, datetime: DateTime.now - 1.day, status: 2) }
  let!(:goal11) { FactoryGirl.create(:goal, match: match4, team: team2) }
  let!(:goal12) { FactoryGirl.create(:goal, match: match4, team: team2) }
  let!(:goal13) { FactoryGirl.create(:goal, match: match4, team: team2) }
  let!(:goal14) { FactoryGirl.create(:goal, match: match4, team: team1) }
  let!(:goal15) { FactoryGirl.create(:goal, match: match4, team: team1) }    
  let!(:match5) { FactoryGirl.create(:match, home_team: team1, away_team: team2, datetime: DateTime.now + 1.day, status: 0) }
  let!(:yellow_card1) { FactoryGirl.create(:card, card_type: :yellow, match: match1, team: team1) }
  let!(:yellow_card2) { FactoryGirl.create(:card, card_type: :yellow, match: match2, team: team2) }
  let!(:yellow_card3) { FactoryGirl.create(:card, card_type: :yellow, match: match3, team: team2) }
  let!(:yellow_card4) { FactoryGirl.create(:card, card_type: :yellow, match: match3, team: team2) }
  let!(:red_card1) { FactoryGirl.create(:card, card_type: :red, match: match1, team: team1) }
  let!(:red_card2) { FactoryGirl.create(:card, card_type: :red, match: match2, team: team2) }
  let!(:red_card3) { FactoryGirl.create(:card, card_type: :red, match: match3, team: team2) }
  
  before do
    match1.save
    match2.save
    match3.save
    match4.save
    @match_preview = MatchPreview.new(match: match)
  end
  
  subject { @match_preview }
 
  it { is_expected.to respond_to(:match) }
  
  it_should_behave_like "preview" 
  
  describe '#match' do
    specify { expect(@match_preview.match).to eq match } 
  end 

  describe '#previous_meetings' do
    specify { expect(@match_preview.previous_meetings).to eq [ match4, match3, match2, match1 ] } 
  end 
    
end
