require 'rails_helper'

describe D11MatchDaysController, type: :controller do

  it_should_behave_like "show controller"
  
  it_should_behave_like "select controller"

  it_should_behave_like "admin action controller", :update
  
end
