require 'rails_helper'

describe TransferWindow, type: :model do
  let(:season) { FactoryGirl.create(:season) }
  let(:d11_match_day) { FactoryGirl.create(:d11_match_day) }
  let(:datetime) { DateTime.now }
  
  before { @transfer_window = FactoryGirl.create(:transfer_window, season: season, d11_match_day: d11_match_day, transfer_window_number: 1, status: :pending, datetime: datetime) }
  
  subject { @transfer_window }

  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:d11_match_day) }
  it { is_expected.to respond_to(:transfer_window_number) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:datetime) }
  it { is_expected.to respond_to(:name) }
  
  it { is_expected.to be_valid }
  
  describe '#season' do
    subject { @transfer_window.season }
    it { is_expected.to eq season }
  end

  describe '#d11_match_day' do
    subject { @transfer_window.d11_match_day }
    it { is_expected.to eq d11_match_day }
  end
  
  describe '#transfer_window_number' do
    subject { @transfer_window.transfer_window_number }
    it { is_expected.to eq 1 }
  end

  describe '#status' do
    subject { @transfer_window.status }
    it { is_expected.to eq :pending.to_s }
  end

  describe '#datetime' do
    subject { @transfer_window.datetime }
    it { is_expected.to eq datetime }
  end
  
  describe '#name' do
    subject { @transfer_window.name }
    it { is_expected.to eq "Transfer window 1" }
  end
  
  describe "default scope order" do
    before { TransferWindow.destroy_all }
    
    let!(:transfer_window1) { FactoryGirl.create(:transfer_window, datetime: DateTime.now - 1.day) }
    let!(:transfer_window2) { FactoryGirl.create(:transfer_window, datetime: DateTime.now) }
    
    specify { expect(TransferWindow.all).to eq [ transfer_window2, transfer_window1 ] }
  end
  
  describe '.current' do
    before { TransferWindow.destroy_all }
    
    let!(:transfer_window1) { FactoryGirl.create(:transfer_window, datetime: DateTime.now - 1.day) }
    let!(:transfer_window2) { FactoryGirl.create(:transfer_window, datetime: DateTime.now) }
    
    specify { expect(TransferWindow.current).to eq transfer_window2 }
  end
  
  describe '#previous' do
    before { TransferWindow.destroy_all }
    
    let(:season) { FactoryGirl.create(:season) }
    let!(:transfer_window1) { FactoryGirl.create(:transfer_window, season: season, transfer_window_number: 1) }
    let!(:transfer_window2) { FactoryGirl.create(:transfer_window, season: season, transfer_window_number: 2) }
    
    specify { expect(transfer_window1.previous).to be_nil }
    specify { expect(transfer_window2.previous).to eq transfer_window1 }
  end

  describe '#next' do
    before { TransferWindow.destroy_all }
    
    let(:season) { FactoryGirl.create(:season) }
    let!(:transfer_window1) { FactoryGirl.create(:transfer_window, season: season, transfer_window_number: 1) }
    let!(:transfer_window2) { FactoryGirl.create(:transfer_window, season: season, transfer_window_number: 2) }
    
    specify { expect(transfer_window1.next).to eq transfer_window2 }
    specify { expect(transfer_window2.next).to be_nil }
  end
  
  context "when season is nil" do
    before { @transfer_window.season = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_match_day is nil" do
    before { @transfer_window.d11_match_day = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when transfer_window_number is nil" do
    before { @transfer_window.transfer_window_number = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when transfer_window_number is invalid" do
    before { @transfer_window.transfer_window_number = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when datetime is nil" do
    before { @transfer_window.datetime = nil }
    it { is_expected.not_to be_valid }
  end

  context "when status is nil" do
    before { @transfer_window.status = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "with transfer_day dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:transfer_window) }
      let!(:dependent) { FactoryGirl.create(:transfer_day, transfer_window: owner) }      
    end
  end
  
end
