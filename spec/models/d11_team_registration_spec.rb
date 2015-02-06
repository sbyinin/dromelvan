require 'rails_helper'

describe D11TeamRegistration, type: :model do
  let(:season) { FactoryGirl.create(:season) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }
  
  before { @d11_team_registration = FactoryGirl.create(:d11_team_registration, season: season, d11_team: d11_team, approved: true) }
  
  subject { @d11_team_registration }
  
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:approved) }
  
  it { is_expected.to be_valid }

  describe '#season' do
    specify { expect(@d11_team_registration.season).to eq season } 
  end 

  describe '#d11_team' do
    specify { expect(@d11_team_registration.d11_team).to eq d11_team } 
  end 

  describe '#approved' do
    specify { expect(@d11_team_registration.approved?).to eq true } 
  end 
  

  context "when season is nil" do
    before { @d11_team_registration.season = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when d11_team is nil" do
    before { @d11_team_registration.d11_team = nil }
    it { is_expected.not_to be_valid }
  end  

  context "when approved is nil" do
    before { @d11_team_registration.approved = nil }
    it { is_expected.not_to be_valid }
  end  
  
  context "when d11_team_registration is not unique in season scope" do
    let(:d11_team_registration) { FactoryGirl.create(:d11_team_registration) }
    
    before do
      # Can't do this in FactoryGirl.create since a validation error will be thrown there.
      d11_team_registration.season = @d11_team_registration.season
      d11_team_registration.d11_team = @d11_team_registration.d11_team
    end
    
    subject { d11_team_registration }    
    it { is_expected.not_to be_valid }
  end   
end
