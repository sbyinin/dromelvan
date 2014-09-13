require 'rails_helper'

describe Season, type: :model do
  before { @season = Season.new(name: "2012-2013", status: 2, date: Date.today, legacy: true) }
  
  subject { @season }
  
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:legacy) }

  it { is_expected.to be_valid }

  describe '#name' do
    subject { @season.name }
    it { is_expected.to eq "2012-2013" }
  end

  describe '#status' do
    subject { @season.status }
    it { is_expected.to eq 2 }
  end

  describe '#date' do
    subject { @season.date }
    it { is_expected.to eq Date.today }
  end

  describe '#legacy' do
    subject { @season.legacy }
    it { is_expected.to eq true }
  end

  describe '.current' do
    before { Season.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, name: Date.today) }
    
    specify { expect(Season.current).to eq season2 }
  end

  it_should_behave_like "named scope"
  
  context "when name is nil" do
    before { @season.name = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when name is blank" do
    before { @season.name = "" }
    it { is_expected.not_to be_valid }
  end
    
  context "when status is nil" do
    before { @season.status = nil }
    it { is_expected.not_to be_valid }
  end

  context "when status is invalid" do
    before { @season.status = 3 }
    it { is_expected.not_to be_valid }
  end
  
  context "when legacy is nil" do
    before { @season.legacy = nil }
    it { is_expected.not_to be_valid }
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:season) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, season: owner) }      
    end
  end

  describe "default scope order" do
    before { Season.destroy_all }
    
    let!(:season1) { FactoryGirl.create(:season, date: Date.today - 1.day) }
    let!(:season2) { FactoryGirl.create(:season, name: Date.today) }
    
    specify { expect(Season.all).to eq [ season2, season1 ] }
  end
  
end
