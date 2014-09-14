require 'rails_helper'

describe "MatchDay", type: :view do
  
  subject { page }

  it_should_behave_like "show view", MatchDay do
    let(:h1_text) { "Match Day #{resource.match_day_number}" }
  end

  pending "final show layout."
  
end
