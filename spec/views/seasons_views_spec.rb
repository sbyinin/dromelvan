require 'rails_helper'

describe "Season", type: :view do
  
  subject { page }

  it_should_behave_like "show view", Season do
    let(:h1_text) { "Season #{resource.name}" }
  end

  pending "final show layout."
  
end
