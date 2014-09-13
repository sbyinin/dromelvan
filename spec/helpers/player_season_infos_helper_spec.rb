require 'rails_helper'

describe PlayerSeasonInfosHelper, type: :helper do

  describe "#player_value" do
    specify { expect(helper.player_value 123).to eq "12.3" }
    specify { expect(helper.player_value 5).to eq "0.5" }
  end
  
end
