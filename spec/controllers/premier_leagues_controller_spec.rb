require 'rails_helper'

describe PremierLeaguesController, type: :controller do

  it_should_behave_like "select controller"

  it_should_behave_like "league table controller"
  
  it_should_behave_like "stats controller"

end
