require 'rails_helper'

describe "D11Team", type: :view do
  
  subject { page }

  it_should_behave_like "index view", D11Team

  it_should_behave_like "show view", D11Team do
    let(:h1_text) { resource.name }
  end
  
end
