require 'rails_helper'

describe Transfer, type: :model do
  let(:transfer_day) { FactoryGirl.create(:transfer_day) }
  let(:player) { FactoryGirl.create(:player) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }

  before { @transfer = FactoryGirl.create(:transfer, transfer_day: transfer_day, player: player, d11_team: d11_team, fee: 5) }
  
  subject { @transfer }
  
  it { is_expected.to respond_to(:transfer_day) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:fee) }

  it { is_expected.to be_valid }
  
  describe '#transfer_day' do
    subject { @transfer.transfer_day }
    it { is_expected.to eq transfer_day }
  end

  describe '#player' do
    subject { @transfer.player }
    it { is_expected.to eq player }
  end
  
  describe '#d11_team' do
    subject { @transfer.d11_team }
    it { is_expected.to eq d11_team }
  end

  describe '#fee' do
    subject { @transfer.fee }
    it { is_expected.to eq 5 }
  end


  context "when transfer_day is nil" do
    before { @transfer.transfer_day = nil }
    it { is_expected.not_to be_valid }
  end

  context "when player is nil" do
    before { @transfer.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_team is nil" do
    before { @transfer.d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when fee is nil" do
    before { @transfer.fee = nil }
    it { is_expected.not_to be_valid }
  end

  context "when fee is too small" do
    before { @transfer.fee = -5 }
    it { is_expected.not_to be_valid }
  end

  context "when fee is invalid" do
    before { @transfer.fee = 1 }
    it { is_expected.not_to be_valid }
  end
  
  describe "default scope order" do
    before { Transfer.destroy_all }
    
    let!(:transfer_day1) { FactoryGirl.create(:transfer_day, datetime: DateTime.now) }
    let!(:transfer_day2) { FactoryGirl.create(:transfer_day, datetime: DateTime.now - 1) }
    let!(:transfer_day3) { FactoryGirl.create(:transfer_day, datetime: DateTime.now + 1) }
    let!(:transfer1) { FactoryGirl.create(:transfer, transfer_day: transfer_day1) }
    let!(:transfer2) { FactoryGirl.create(:transfer, transfer_day: transfer_day2) }
    let!(:transfer3) { FactoryGirl.create(:transfer, transfer_day: transfer_day3) }

    specify { expect(Transfer.all).to eq [ transfer3, transfer1, transfer2 ] }
  end
  
end
