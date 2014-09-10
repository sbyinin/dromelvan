require 'rails_helper'

describe "Season", type: :view do
  
  subject { page }

  it_should_behave_like "index view", Season
  
  it_should_behave_like "show view", Season do
    let(:h1_text) { "Season #{resource.name}" }
  end

  pending "final index layout."
  pending "final show layout."
  
end
