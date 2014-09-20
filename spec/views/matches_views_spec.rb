require 'rails_helper'

describe "Match", type: :view do
  
  subject { page }

  it_should_behave_like "show view", Match do
    let(:h1_text) { resource.name }
  end

  pending "final show layout."
  
end
