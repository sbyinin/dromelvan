require 'rails_helper'

describe D11TeamsController, type: :controller do

  it_should_behave_like "index controller"
  
  it_should_behave_like "show controller"

  it_should_behave_like "select season controller"
  
  it_should_behave_like "select controller"

end
