require 'rails_helper'

describe MatchDay, type: :model do
  
  let(:home_team) { FactoryGirl.create(:team) }
  let(:away_team) { FactoryGirl.create(:team) }
  let(:match_day) { FactoryGirl.create(:match_day) }
  let(:stadium) { FactoryGirl.create(:stadium) }
  
  before { @match = FactoryGirl.create(:match, home_team: home_team, away_team: away_team, match_day: match_day, stadium: stadium, home_team_goals: 1, away_team_goals: 2, datetime: DateTime.now, elapsed: "FT", status: 2, whoscored_id: 1) }
  
  subject { @match }
  
  it { is_expected.to respond_to(:home_team) }
  it { is_expected.to respond_to(:away_team) }
  it { is_expected.to respond_to(:match_day) }
  it { is_expected.to respond_to(:stadium) }
  it { is_expected.to respond_to(:home_team_goals) }
  it { is_expected.to respond_to(:away_team_goals) }
  it { is_expected.to respond_to(:datetime) }
  it { is_expected.to respond_to(:elapsed) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:whoscored_id) }
  
  it { is_expected.to be_valid }
    
end
