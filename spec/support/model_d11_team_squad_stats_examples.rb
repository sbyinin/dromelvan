shared_examples_for "d11 team squad stats summary" do
  
  it_should_behave_like "player stats summary"
  
  it { is_expected.to respond_to(:d11_team) }
  it { is_expected.to respond_to(:team_goals) }


  describe '#d11_team' do
    specify { expect(subject.d11_team).to eq d11_team } 
  end

  describe '#team_goals' do
    specify { expect(subject.team_goals).to eq 0 } 
  end

  
  context "when d11_team is nil" do
    before { subject.d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when team_goals is nil" do
    # Team goals is calculated in before_validate.
    before { subject.team_goals = nil }
    it { is_expected.to be_valid }
  end
  
  context "when team_goals is invalid" do
    before { subject.team_goals = -1 }
    it { is_expected.to be_valid }
  end
    
end