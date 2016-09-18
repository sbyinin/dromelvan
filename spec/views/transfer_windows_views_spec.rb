require 'rails_helper'

describe "TransferWindow", type: :view do
  
  subject { page }

  it_should_behave_like "show view", TransferWindow do
    let(:h1_text) { resource.name }
    
    context "when dependents don't exist" do
      before { visit transfer_window_path(resource) }
      
      it { is_expected.not_to have_selector("div#transfer-day-highest-bids") }
      it { is_expected.not_to have_selector("div#transfer-day-most-expensive-transfers") }  
      it { is_expected.not_to have_selector("div#transfer-day-top-transfer-listings") }
      it { is_expected.not_to have_selector("div#transfer-day-stats") }
    end

    context "when dependents exist" do
      let!(:transfer_day) { FactoryGirl.create(:transfer_day, transfer_window: resource) }

      before { visit transfer_window_path(resource) }
      
      it { is_expected.to have_selector("div#transfer-day-highest-bids") }
      it { is_expected.to have_selector("div#transfer-day-most-expensive-transfers") }  
      it { is_expected.to have_selector("div#transfer-day-top-transfer-listings") }
      it { is_expected.to have_selector("div#transfer-day-stats") }
    end

  end
  
end
