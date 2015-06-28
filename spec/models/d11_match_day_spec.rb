require 'rails_helper'

describe D11MatchDay, type: :model do
  
  let(:d11_league) { FactoryGirl.create(:d11_league) }
  let(:match_day) { FactoryGirl.create(:match_day) }
  
  before { @d11_match_day = FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day: match_day, date: Date.today, match_day_number: 1) }
  
  subject { @d11_match_day }
  
  it { is_expected.to respond_to(:d11_league) }
  it { is_expected.to respond_to(:match_day) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:match_day_number) }
  it { is_expected.to respond_to(:name) }
  
  it { is_expected.to be_valid }
  
  describe '#d11_league' do
    subject { @d11_match_day.d11_league }
    it { is_expected.to eq d11_league }
  end

  describe '#match_day' do
    subject { @d11_match_day.match_day }
    it { is_expected.to eq match_day }
  end

  describe '#date' do
    subject { @d11_match_day.date }
    it { is_expected.to eq Date.today }
  end
    
  describe '#match_day_number' do
    subject { @d11_match_day.match_day_number }
    it { is_expected.to eq 1 }
  end
  
  describe '#name' do
    subject { @d11_match_day.name }
    it { is_expected.to eq "Match Day #{@d11_match_day.match_day_number}" }
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
  
  describe '#match_dates' do    
    let!(:match_day1) { FactoryGirl.create(:match_day) }
    let!(:match_day2) { FactoryGirl.create(:match_day) }
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, match_day: match_day1) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, match_day: match_day2) }
    let!(:match1) { FactoryGirl.create(:match, match_day: match_day1, datetime: DateTime.now - 4.days) }
    let!(:match2) { FactoryGirl.create(:match, match_day: match_day1, datetime: DateTime.now - 3.days) }
    let!(:match3) { FactoryGirl.create(:match, match_day: match_day2, datetime: DateTime.now - 2.days) }
    let!(:match4) { FactoryGirl.create(:match, match_day: match_day2, datetime: DateTime.now - 2.days) }    
    let!(:d11_match1) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day1) }
    let!(:d11_match2) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day1) }
    let!(:d11_match3) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day2) }
    let!(:d11_match4) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day2) }    
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, match: match1, d11_team: d11_match1.home_d11_team) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, match: match2, d11_team: d11_match2.away_d11_team) }
    let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, match: match3, d11_team: d11_match3.home_d11_team) }
    let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, match: match4, d11_team: d11_match4.away_d11_team) }
    
    specify { expect(d11_match_day1.match_dates).to eq [ match1.datetime.to_date, match2.datetime.to_date ] }
    specify { expect(d11_match_day2.match_dates).to eq [ match3.datetime.to_date ] }
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

  context "when match_day is nil" do
    before { @d11_match_day.match_day = nil }
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

  context "with d11_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_match_day) }
      let!(:dependent) { FactoryGirl.create(:d11_match, d11_match_day: owner) }      
    end
  end

  context "with transfer_window dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_match_day) }
      let!(:dependent) { FactoryGirl.create(:transfer_window, d11_match_day: owner) }      
    end
  end

  context "with d11_team_table_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_match_day) }
      let!(:dependent) { FactoryGirl.create(:d11_team_table_stat, d11_match_day: owner) }      
    end
  end
  
end
