require 'rails_helper'

describe MatchDay, type: :model do
  
  let(:premier_league) { FactoryGirl.create(:premier_league) }
  
  before { @match_day = FactoryGirl.create(:match_day, premier_league: premier_league, date: Date.today, match_day_number: 1) }
  
  subject { @match_day }
  
  it { is_expected.to respond_to(:premier_league) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:match_day_number) }
  it { is_expected.to respond_to(:name) }
  
  it { is_expected.to be_valid }
    
  describe '#premier_league' do
    subject { @match_day.premier_league }
    it { is_expected.to eq premier_league }
  end

  describe '#date' do
    subject { @match_day.date }
    it { is_expected.to eq Date.today }
  end
    
  describe '#match_day_number' do
    subject { @match_day.match_day_number }
    it { is_expected.to eq 1 }
  end

  describe '#name' do
    subject { @match_day.name }
    it { is_expected.to eq "Match Day #{@match_day.match_day_number}" }
  end

  describe '#previous' do
    before { MatchDay.destroy_all }
    
    let(:premier_league) { FactoryGirl.create(:premier_league) }
    let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1) }
    let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 2) }
    
    specify { expect(match_day1.previous).to be_nil }
    specify { expect(match_day2.previous).to eq match_day1 }
  end

  describe '#next' do
    before { MatchDay.destroy_all }
    
    let(:premier_league) { FactoryGirl.create(:premier_league) }
    let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1) }
    let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 2) }
    
    specify { expect(match_day1.next).to eq match_day2 }
    specify { expect(match_day2.next).to be_nil }
  end
    
  describe '.current' do
    before { MatchDay.destroy_all }
    
    let!(:match_day1) { FactoryGirl.create(:match_day, date: Date.today - 1.day) }
    let!(:match_day2) { FactoryGirl.create(:match_day, date: Date.today) }
    let!(:match_day3) { FactoryGirl.create(:match_day, date: Date.today + 1.day) }
    
    specify { expect(MatchDay.current).to eq match_day2 }
  end
    
  context "when premier_league is nil" do
    before { @match_day.premier_league = nil }
    it { is_expected.not_to be_valid }
  end

  context "when date is nil" do
    before { @match_day.date = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match_day_number is nil" do
    before { @match_day.match_day_number = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match_day_number is invalid" do
    before { @match_day.match_day_number = -1 }
    it { is_expected.not_to be_valid }
  end
    
  describe "default scope order" do
    before { MatchDay.destroy_all }
    
    let!(:match_day1) { FactoryGirl.create(:match_day, date: Date.today) }
    let!(:match_day2) { FactoryGirl.create(:match_day, date: Date.today - 1.day) }
    
    specify { expect(MatchDay.all).to eq [ match_day2, match_day1 ] }
  end

  context "with match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:match_day) }
      let!(:dependent) { FactoryGirl.create(:match, match_day: owner) }      
    end
  end
    
end
