require 'rails_helper'

describe D11MatchDay, type: :model do
  
  let(:d11_league) { FactoryGirl.create(:d11_league) }
  
  before { @d11_match_day = FactoryGirl.create(:d11_match_day, d11_league: d11_league, date: Date.today, match_day_number: 1) }
  
  subject { @d11_match_day }
  
  it { is_expected.to respond_to(:d11_league) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:match_day_number) }
  it { is_expected.to respond_to(:match_day) }
  
  it { is_expected.to be_valid }
  
  describe '#d11_league' do
    subject { @d11_match_day.d11_league }
    it { is_expected.to eq d11_league }
  end

  describe '#date' do
    subject { @d11_match_day.date }
    it { is_expected.to eq Date.today }
  end
    
  describe '#match_day_number' do
    subject { @d11_match_day.match_day_number }
    it { is_expected.to eq 1 }
  end

  describe '#match_day' do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 38) }
    let(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
    let(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 38) }
    
    specify { expect(d11_match_day.match_day).to eq match_day }
  end

  describe '#previous' do
    before { D11MatchDay.destroy_all }
    
    let(:d11_league) { FactoryGirl.create(:d11_league) }
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 1) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 2) }
    
    specify { expect(d11_match_day1.previous).to be_nil }
    specify { expect(d11_match_day2.previous).to eq d11_match_day1 }
  end

  describe '#next' do
    before { D11MatchDay.destroy_all }
    
    let(:d11_league) { FactoryGirl.create(:d11_league) }
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 1) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 2) }
    
    specify { expect(d11_match_day1.next).to eq d11_match_day2 }
    specify { expect(d11_match_day2.next).to be_nil }
  end
  
  describe '.current' do
    before { D11MatchDay.destroy_all }
    
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, date: Date.today - 1.day) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, date: Date.today) }
    let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, date: Date.today + 1.day) }
    
    specify { expect(D11MatchDay.current).to eq d11_match_day2 }
  end
  
  context "when d11_league is nil" do
    before { @d11_match_day.d11_league = nil }
    it { is_expected.not_to be_valid }
  end

  context "when date is nil" do
    before { @d11_match_day.date = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match_day_number is nil" do
    before { @d11_match_day.match_day_number = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match_day_number is invalid" do
    before { @d11_match_day.match_day_number = -1 }
    it { is_expected.not_to be_valid }
  end
    
  describe "default scope order" do
    before { D11MatchDay.destroy_all }
    
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, date: Date.today) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, date: Date.today - 1.day) }
    
    specify { expect(D11MatchDay.all).to eq [ d11_match_day2, d11_match_day1 ] }
  end
  
end
