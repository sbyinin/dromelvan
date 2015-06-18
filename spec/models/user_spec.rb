require 'rails_helper'

describe User, type: :model do

  it { is_expected.to respond_to(:owned_d11_teams) }
  it { is_expected.to respond_to(:co_owned_d11_teams) }
  it { is_expected.to respond_to(:posts) }
  it { is_expected.to respond_to(:active_d11_team) }

  describe '#active_d11_team' do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:owner) { FactoryGirl.create(:user) }
    let!(:co_owner) { FactoryGirl.create(:user) }
    let!(:d11_team1) { FactoryGirl.create(:d11_team, owner: user) }
    let!(:d11_team2) { FactoryGirl.create(:d11_team, owner: owner, co_owner: co_owner) }
    let!(:season) { FactoryGirl.create(:season) }
    let!(:d11_team_registration1) { FactoryGirl.create(:d11_team_registration, season: season, d11_team: d11_team1, approved: false) }
    let!(:d11_team_registration2) { FactoryGirl.create(:d11_team_registration, season: season, d11_team: d11_team2, approved: true) }

    specify { expect(user.active_d11_team).to be_nil }
    specify { expect(owner.active_d11_team).to eq d11_team2 }
    specify { expect(co_owner.active_d11_team).to eq d11_team2 }
  end

  context "with owned_d11_team dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:user) }
      let!(:dependent) { FactoryGirl.create(:d11_team, owner: owner) }      
    end
  end

  context "with co_owned_d11_team dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:user) }
      let!(:dependent) { FactoryGirl.create(:d11_team, co_owner: owner) }      
    end
  end

  context "with post dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:user) }
      let!(:dependent) { FactoryGirl.create(:post, user: owner) }      
    end
  end

end
