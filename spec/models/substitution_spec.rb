require 'rails_helper'

describe Substitution, type: :model do
  let(:match) { FactoryGirl.create(:match) }
  let(:team) { match.home_team }
  let(:player) { FactoryGirl.create(:player) }
  let(:player_in) { FactoryGirl.create(:player) }
  let(:time) { 30 }
  let(:added_time) { 0 }
  
  before { @substitution = FactoryGirl.create(:substitution, match: match, team: team, player: player, player_in: player_in, time: time, added_time: added_time) }
  
  subject { @substitution }
  
  it { is_expected.to respond_to(:player_in) }
  
  it { is_expected.to be_valid }
  
  describe '#player_in' do
    subject { @substitution.player_in }
    it { is_expected.to eq player_in }
  end    
  
  it_should_behave_like "match event" do
    let(:match_event) { @substitution }
  end
  
  context "when player_in is nil" do
    before { @substitution.player_in = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when player, player_in is invalid" do
    before { @substitution.player_in = @substitution.player }
    
    it { is_expected.not_to be_valid }
  end   
end
