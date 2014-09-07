require 'rails_helper'

describe "Player", type: :view do
  
  subject { page }

  it_should_behave_like "index view", Player

  it_should_behave_like "show view", Player do
    let(:h1_text) { resource.name }
  end

  pending "season selector and final show layout."
  
end
