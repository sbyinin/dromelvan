require 'rails_helper'

describe Position, type: :model do
  before { @position = Position.new(name: "Position", code: "P", defender: false, sort_order: 1) }
  
  subject { @position }
  
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:defender) }
  it { is_expected.to respond_to(:sort_order) }

  it { is_expected.to be_valid }
  
  describe '#name' do
    subject { @position.name }
    it { is_expected.to eq "Position" }
  end

  describe '#code' do
    subject { @position.code }
    it { is_expected.to eq "P" }
  end

  describe '#defender' do
    subject { @position.defender }
    it { is_expected.to eq false }
  end

  describe '#sort_order' do
    subject { @position.sort_order }
    it { is_expected.to eq 1 }
  end
  
  context "when name is blank" do
    before { @position.name = "" }
    it { is_expected.not_to be_valid }
  end
      
  context "when name is not unique" do
    let!(:position) { FactoryGirl.create(:position, name: @position.name) }
    it { should_not be_valid }
  end
  
  context "when code is blank" do
    before { @position.code = "" }
    it { is_expected.not_to be_valid }
  end

  context "when code is not unique" do
    let!(:position) { FactoryGirl.create(:position, code: @position.code) }
    it { should_not be_valid }
  end

  context "when defender is nil" do
    before { @position.defender = nil }
    it { is_expected.not_to be_valid }
  end

  context "when sort_order is nil" do
    before { @position.sort_order = nil }
    it { is_expected.not_to be_valid }
  end

  context "when sort_order is not unique" do
    let!(:position) { FactoryGirl.create(:position, sort_order: @position.sort_order) }
    it { should_not be_valid }
  end

  describe "default scope order" do
    before { Position.destroy_all }
    
    let!(:position1) { FactoryGirl.create(:position, sort_order: 2) }
    let!(:position2) { FactoryGirl.create(:position, sort_order: 1) }
    
    specify { expect(Position.all).to eq [ position2, position1 ] }
  end

end
