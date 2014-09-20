require 'rails_helper'

describe Stadium, type: :model do

  before { @stadium = FactoryGirl.create(:stadium, name: "Test Stadium", city: "Test City", capacity: 100, opened: 1900) }
  
  subject { @stadium }
  
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:city) }
  it { is_expected.to respond_to(:capacity) }
  it { is_expected.to respond_to(:opened) }
  it { is_expected.to respond_to(:photo) }

  it { is_expected.to be_valid }

  describe '#name' do
    subject { @stadium.name }
    it { is_expected.to eq "Test Stadium" }
  end

  describe '#city' do
    subject { @stadium.city }
    it { is_expected.to eq "Test City" }
  end

  describe '#capacity' do
    subject { @stadium.capacity }
    it { is_expected.to eq 100 }
  end

  describe '#opened' do
    subject { @stadium.opened }
    it { is_expected.to eq 1900 }
  end

  it_should_behave_like "named scope"
  it_should_behave_like "name ordered"
  
  context "with team dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:stadium) }
      let!(:dependent) { FactoryGirl.create(:team, stadium: owner) }      
    end
  end

  context "with match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:stadium) }
      let!(:dependent) { FactoryGirl.create(:match, stadium: owner) }      
    end
  end
  
  context "when name is blank" do
    before { @stadium.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "when city is blank" do
    before { @stadium.city = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when capacity is nil" do
    before { @stadium.capacity = nil }
    it { is_expected.not_to be_valid }
  end

  context "when capacity is invalid" do
    before { @stadium.capacity = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when opened is nil" do
    before { @stadium.opened = nil }
    it { is_expected.not_to be_valid }
  end

  context "when opened is invalid" do
    before { @stadium.opened = -1 }
    it { is_expected.not_to be_valid }
  end
  
end
