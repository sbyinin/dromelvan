require 'rails_helper'

describe "TransferWindow", type: :view do
  
  subject { page }

  it_should_behave_like "show view", TransferWindow do
    let(:h1_text) { resource.name }
  end
  
end
