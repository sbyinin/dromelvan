require 'rails_helper'

describe "Team", type: :view do
  
  subject { page }

  it_should_behave_like "index view", Team

  it_should_behave_like "show view", Team do
    let(:h1_text) { resource.name }
  end

  pending "final show and index layout."
  
end
