require 'rails_helper'

describe MatchDaysController, type: :controller do

  it_should_behave_like "show controller"
  
  it_should_behave_like "select controller"
  
  it_should_behave_like "status enum controller"

  it_should_behave_like "admin action controller", :update
  
end
