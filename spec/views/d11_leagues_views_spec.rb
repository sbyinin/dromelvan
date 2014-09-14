require 'rails_helper'

describe "D11League", type: :view do
    
  subject { page }  

  it_should_behave_like "show view", D11League do
    let(:h1_text) { resource.name }
  end

  pending "final show layout."
  
end
