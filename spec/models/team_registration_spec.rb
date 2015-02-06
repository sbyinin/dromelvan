require 'rails_helper'

describe TeamRegistration, type: :model do
  let(:season) { FactoryGirl.create(:season) }
  let(:team) { FactoryGirl.create(:team) }
  
  before { @team_registration = FactoryGirl.create(:team_registration, season: season, team: team) }
  
  subject { @team_registration }
  
  it { is_expected.to respond_to(:season) }
  it { is_expected.to respond_to(:team) }
  
  it { is_expected.to be_valid }

  describe '#season' do
    specify { expect(@team_registration.season).to eq season } 
  end 

  describe '#team' do
    specify { expect(@team_registration.team).to eq team } 
  end 
  

  context "when season is nil" do
    before { @team_registration.season = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when team is nil" do
    before { @team_registration.team = nil }
    it { is_expected.not_to be_valid }
  end  
  
  context "when team_registration is not unique in season scope" do
    let(:team_registration) { FactoryGirl.create(:team_registration) }
    
    before do
      # Can't do this in FactoryGirl.create since a validation error will be thrown there.
      team_registration.season = @team_registration.season
      team_registration.team = @team_registration.team
    end
    
    subject { team_registration }    
    it { is_expected.not_to be_valid }
  end   
end
