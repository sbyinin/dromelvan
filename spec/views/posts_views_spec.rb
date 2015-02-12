require 'rails_helper'

describe "Post", type: :view do
    
  subject { page }  
  
  it_should_behave_like "index view", Post

  pending "all post view specs."
  
  pending "final index layout."
  
end
