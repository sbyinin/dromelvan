require 'rails_helper'

describe "D11Match", type: :view do
  
  subject { page }

  it_should_behave_like "show view", Match do
    let(:h1_text) { resource.name }
  end

end
