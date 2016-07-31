require 'rails_helper'

describe PlayerSeasonInfosController, type: :controller do

  it_should_behave_like "admin action controller", :edit
  it_should_behave_like "admin action controller", :update
  
end
