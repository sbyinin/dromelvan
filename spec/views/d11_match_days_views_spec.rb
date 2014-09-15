require 'rails_helper'

describe "D11MatchDay", type: :view do
  
  subject { page }

  it_should_behave_like "show view", D11MatchDay do
    let(:h1_text) { "D11 Match Day #{resource.match_day_number}" }
  end

  pending "final show layout."
  
end
