require 'rails_helper'

describe PlayersController, type: :controller do

  it_should_behave_like "index controller"
  
  it_should_behave_like "show controller"
  
end
