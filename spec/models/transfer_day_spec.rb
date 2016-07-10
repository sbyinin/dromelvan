require 'rails_helper'

describe TransferDay, type: :model do
  let(:transfer_window) { FactoryGirl.create(:transfer_window) }
  let(:datetime) { DateTime.now }

  before { @transfer_day = FactoryGirl.create(:transfer_day, transfer_window: transfer_window, transfer_day_number: 1, status: :pending, datetime: datetime) }
  
  subject { @transfer_day }
  
  it { is_expected.to respond_to(:transfer_window) }
  it { is_expected.to respond_to(:transfer_day_number) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:datetime) }
  
  it { is_expected.to be_valid }
  
  describe '#transfer_window' do
    subject { @transfer_day.transfer_window }
    it { is_expected.to eq transfer_window }
  end

  describe '#transfer_day_number' do
    subject { @transfer_day.transfer_day_number }
    it { is_expected.to eq 1 }
  end
  
  describe '#status' do
    subject { @transfer_day.status }
    it { is_expected.to eq :pending.to_s }
  end
  
  describe '#datetime' do
    subject { @transfer_day.datetime }
    it { is_expected.to eq datetime }
  end

  describe '#name' do
    subject { @transfer_day.name }
    it { is_expected.to eq "Transfer Day 1" }
  end
  
  describe "default scope order" do
    before { TransferDay.destroy_all }
    
    let!(:transfer_day1) { FactoryGirl.create(:transfer_day, datetime: DateTime.now - 1.day) }
    let!(:transfer_day2) { FactoryGirl.create(:transfer_day, datetime: DateTime.now) }
    
    specify { expect(TransferDay.all).to eq [ transfer_day2, transfer_day1 ] }
  end
  
  describe '.current' do
    before { TransferDay.destroy_all }
    
    let!(:transfer_day1) { FactoryGirl.create(:transfer_day, datetime: DateTime.now - 1.day) }
    let!(:transfer_day2) { FactoryGirl.create(:transfer_day, datetime: DateTime.now) }
    
    specify { expect(TransferDay.current).to eq transfer_day2 }
  end

  describe '#previous' do
    before { TransferDay.destroy_all }
    
    let(:transfer_window) { FactoryGirl.create(:transfer_window) }
    let!(:transfer_day1) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window, transfer_day_number: 1) }
    let!(:transfer_day2) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window, transfer_day_number: 2) }
    
    specify { expect(transfer_day1.previous).to be_nil }
    specify { expect(transfer_day2.previous).to eq transfer_day1 }
  end

  describe '#next' do
    before { TransferDay.destroy_all }
    
    let(:transfer_window) { FactoryGirl.create(:transfer_window) }
    let!(:transfer_day1) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window, transfer_day_number: 1) }
    let!(:transfer_day2) { FactoryGirl.create(:transfer_day, transfer_window: transfer_window, transfer_day_number: 2) }
    
    specify { expect(transfer_day1.next).to eq transfer_day2 }
    specify { expect(transfer_day2.next).to be_nil }
  end

  context "when transfer_window is nil" do
    before { @transfer_day.transfer_window = nil }
    it { is_expected.not_to be_valid }
  end

  context "when transfer_day_number is nil" do
    before { @transfer_day.transfer_day_number = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when transfer_day_number is invalid" do
    before { @transfer_day.transfer_day_number = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when status is nil" do
    before { @transfer_day.status = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when datetime is nil" do
    before { @transfer_day.datetime = nil }
    it { is_expected.not_to be_valid }
  end

  context "with transfer_listing dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:transfer_day) }
      let!(:dependent) { FactoryGirl.create(:transfer_listing, transfer_day: owner) }      
    end
  end

  context "with transfer dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:transfer_day) }
      let!(:dependent) { FactoryGirl.create(:transfer, transfer_day: owner) }      
    end
  end

  context "with transfer_bid dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:transfer_day) }
      let!(:dependent) { FactoryGirl.create(:transfer_bid, transfer_day: owner) }      
    end
  end
  
end

