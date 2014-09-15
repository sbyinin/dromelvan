require 'rails_helper'

describe "D11MatchDay", type: :view do
  
  subject { page }

  it_should_behave_like "show view", D11MatchDay do
    let(:h1_text) { resource.name }
  end

  pending "final show layout."
  
end
