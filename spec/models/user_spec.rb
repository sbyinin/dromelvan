require 'rails_helper'

describe User, type: :model do

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

end
