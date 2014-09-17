require 'rails_helper'

describe MatchDay, type: :model do
  
  let(:home_team) { FactoryGirl.create(:team) }
  let(:away_team) { FactoryGirl.create(:team) }
  let(:match_day) { FactoryGirl.create(:match_day) }
  let(:stadium) { FactoryGirl.create(:stadium) }
  let(:datetime) { DateTime.now }
  
  before { @match = FactoryGirl.create(:match, home_team: home_team, away_team: away_team, match_day: match_day, stadium: stadium, home_team_goals: 1, away_team_goals: 2, datetime: datetime, elapsed: "FT", status: 2, whoscored_id: 1) }
  
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
    
  describe '#home_team' do
    subject { @match.home_team }
    it { is_expected.to eq home_team }
  end
    
  describe '#away_team' do
    subject { @match.away_team }
    it { is_expected.to eq away_team }
  end
    
  describe '#match_day' do
    subject { @match.match_day }
    it { is_expected.to eq match_day }
  end
    
  describe '#stadium' do
    subject { @match.stadium }
    it { is_expected.to eq stadium }
  end

  describe '#home_team_goals' do
    subject { @match.home_team_goals }
    it { is_expected.to eq 1 }
  end

  describe '#away_team_goals' do
    subject { @match.away_team_goals }
    it { is_expected.to eq 2 }
  end

  describe '#datetime' do
    subject { @match.datetime }
    it { is_expected.to eq datetime }
  end

  describe '#elapsed' do
    subject { @match.elapsed }
    it { is_expected.to eq "FT" }
  end

  describe '#status' do
    subject { @match.status }
    it { is_expected.to eq 2 }
  end

  describe '#whoscored_id' do
    subject { @match.whoscored_id }
    it { is_expected.to eq 1 }
  end

end
