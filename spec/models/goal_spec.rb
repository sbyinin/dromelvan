require 'rails_helper'

describe Goal, type: :model do

  let(:match) { FactoryGirl.create(:match) }
  let(:team) { match.home_team }
  let(:player) { FactoryGirl.create(:player) }
  let(:time) { 30 }
  let(:added_time) { 0 }
  
  before { @goal = FactoryGirl.create(:goal, match: match, team: team, player: player, time: time, added_time: added_time, penalty: false, own_goal: false) }
  
  subject { @goal }
  
  it { is_expected.to respond_to(:penalty) }
  it { is_expected.to respond_to(:own_goal) }
  
  it { is_expected.to be_valid }
  
  describe '#penalty' do
    subject { @goal.penalty }
    it { is_expected.to eq false }
  end
  
  describe '#own_goal' do
    subject { @goal.own_goal }
    it { is_expected.to eq false }
  end    
  
  it_should_behave_like "match event" do
    let(:match_event) { @goal }
  end
  
  context "when penalty is nil" do
    before { @goal.penalty = nil }
    it { is_expected.not_to be_valid }
  end

  context "when own_goal is nil" do
    before { @goal.own_goal = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when penalty, own_goal is invalid" do
    before do
      @goal.penalty = true
      @goal.own_goal = true      
    end
    
    it { is_expected.not_to be_valid }
  end
  
end
