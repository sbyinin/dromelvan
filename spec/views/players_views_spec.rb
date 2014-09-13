require 'rails_helper'

describe "Player", type: :view do
    
  subject { page }  

  # This is needed so that the default player_season_info created will have values that aren't nil.    
  let!(:team) { FactoryGirl.create(:team, name: "None") }
  let!(:d11_team) { FactoryGirl.create(:d11_team, name: "None") }
  let!(:position) { FactoryGirl.create(:position, name: "Unknown") }
  
  it_should_behave_like "index view", Player

  it_should_behave_like "show view", Player do
    let(:h1_text) { resource.name }
  end

  pending "final show layout."
  
end
