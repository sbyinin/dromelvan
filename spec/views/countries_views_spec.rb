require 'rails_helper'

describe "Country", type: :view do
  
  subject { page }

  it_should_behave_like "index view", Country

  it_should_behave_like "show view", Country do
    let(:h1_text) { resource.name }
  end

  pending "final show layout."
  
end
