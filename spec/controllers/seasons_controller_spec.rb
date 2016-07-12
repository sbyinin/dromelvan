require 'rails_helper'

describe SeasonsController, type: :controller do

  it_should_behave_like "index controller"
  
  it_should_behave_like "select controller"

end
