require 'rails_helper'

describe Card, type: :model do
  let(:match) { FactoryGirl.create(:match) }
  let(:team) { match.home_team }
  let(:player) { FactoryGirl.create(:player) }
  let(:time) { 30 }
  let(:added_time) { 0 }
  
  before { @card = FactoryGirl.create(:card, match: match, team: team, player: player, time: time, added_time: added_time, card_type: 0) }
  
  subject { @card }
  
  it { is_expected.to respond_to(:card_type) }
  it { is_expected.to respond_to(:yellow?) }
  it { is_expected.to respond_to(:red?) }
  
  it { is_expected.to be_valid }

  describe '#card_type' do
    subject { @card.card_type }
    it { is_expected.to eq :yellow.to_s }
  end    
  
  describe '#yellow?' do
    subject { @card.yellow? }
    it { is_expected.to eq true }
  end

  describe '#red?' do
    subject { @card.red? }
    it { is_expected.to eq false }
  end
  
  it_should_behave_like "match event" do
    let(:match_event) { @card }
  end
  
  context "when card_type is nil" do
    before { @card.card_type = nil }
    it { is_expected.not_to be_valid }
  end
  
end
