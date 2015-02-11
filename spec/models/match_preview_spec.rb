require 'rails_helper'

describe MatchPreview, type: :model do
  let(:match) { FactoryGirl.create(:match) }
  let(:team1) { match.home_team }
  let(:team2) { match.away_team }
  let!(:match1) { FactoryGirl.create(:match, home_team: team1, away_team: team2, home_team_goals: 1, away_team_goals: 2, datetime: DateTime.now - 4.day, status: 2) }
  let!(:match2) { FactoryGirl.create(:match, home_team: team2, away_team: team1, home_team_goals: 1, away_team_goals: 2, datetime: DateTime.now - 3.day, status: 2) }
  let!(:match3) { FactoryGirl.create(:match, home_team: team1, away_team: team2, home_team_goals: 2, away_team_goals: 2, datetime: DateTime.now - 2.day, status: 2) }
  let!(:match4) { FactoryGirl.create(:match, home_team: team2, away_team: team1, home_team_goals: 3, away_team_goals: 2, datetime: DateTime.now - 1.day, status: 2) }
  let!(:match5) { FactoryGirl.create(:match, home_team: team1, away_team: team2, datetime: DateTime.now + 1.day, status: 0) }
  let!(:yellow_card1) { FactoryGirl.create(:card, card_type: :yellow, match: match1, team: team1) }
  let!(:yellow_card2) { FactoryGirl.create(:card, card_type: :yellow, match: match2, team: team2) }
  let!(:yellow_card3) { FactoryGirl.create(:card, card_type: :yellow, match: match3, team: team2) }
  let!(:yellow_card4) { FactoryGirl.create(:card, card_type: :yellow, match: match3, team: team2) }
  let!(:red_card1) { FactoryGirl.create(:card, card_type: :red, match: match1, team: team1) }
  let!(:red_card2) { FactoryGirl.create(:card, card_type: :red, match: match2, team: team2) }
  let!(:red_card3) { FactoryGirl.create(:card, card_type: :red, match: match3, team: team2) }
  
  before { @match_preview = MatchPreview.new(match: match) }
  
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
