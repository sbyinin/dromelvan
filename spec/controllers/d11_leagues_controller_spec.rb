require 'rails_helper'

describe D11LeaguesController, type: :controller do

  it_should_behave_like "select controller"

  it_should_behave_like "league table controller"
  
  it_should_behave_like "d11 teams controller"
  
end
