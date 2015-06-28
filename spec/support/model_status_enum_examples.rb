shared_examples_for "status enum" do

  it { is_expected.to respond_to(:status) }
  
  describe '#status' do
    subject { resource.status }
    it { is_expected.to eq :finished.to_s }
  end
  
  context "when status is nil" do
    before { resource.status = nil }
    it { is_expected.not_to be_valid }
  end
    
end