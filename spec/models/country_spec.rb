require 'rails_helper'

describe Country, type: :model do
  before { @country = FactoryGirl.create(:country, name: "Country", iso: "CO") }
  
  subject { @country }
  
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:iso) }

  it { is_expected.to be_valid }
  
  describe '#name' do
    subject { @country.name }
    it { is_expected.to eq "Country" }
  end

  describe '#iso' do
    subject { @country.iso }
    it { is_expected.to eq "CO" }
  end
  
  it_should_behave_like "named scope"

  context "with player dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:country) }
      let!(:dependent) { FactoryGirl.create(:player, country: owner) }      
    end
  end

  context "when name is blank." do
    before { @country.name = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when iso is blank." do
    before { @country.iso = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when iso is too short." do
    before { @country.iso = "A" }
    it { is_expected.not_to be_valid }
  end
  
  context "when iso is too long." do
    before { @country.iso = "AAAA" }
    it { is_expected.not_to be_valid }
  end    

  describe "default scope order" do
    before { Country.destroy_all }
    
    let!(:country1) { FactoryGirl.create(:country, name: "CountryB") }
    let!(:country2) { FactoryGirl.create(:country, name: "CountryA") }
    
    specify { expect(Country.all).to eq [ country2, country1 ] }
  end

end
