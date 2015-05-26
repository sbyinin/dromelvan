require 'rails_helper'

describe PostsController, type: :controller do

  it_should_behave_like "index controller"
  
  it_should_behave_like "show controller"

  it_should_behave_like "admin action controller", :new
  it_should_behave_like "admin action controller", :create
  it_should_behave_like "admin action controller", :edit
  it_should_behave_like "admin action controller", :update
  
end
