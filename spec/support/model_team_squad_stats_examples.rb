shared_examples_for "team squad stats summary" do
  
  it_should_behave_like "player stats summary"
  
  it { is_expected.to respond_to(:team) }


  describe '#team' do
    specify { expect(subject.team).to eq team } 
  end

  
  context "when team is nil" do
    before { subject.team = nil }
    it { is_expected.not_to be_valid }
  end
    
end