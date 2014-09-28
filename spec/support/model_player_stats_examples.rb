shared_examples_for "player stats" do |reset|

  it { is_expected.to respond_to(:goals) }
  it { is_expected.to respond_to(:goal_assists) }
  it { is_expected.to respond_to(:own_goals) }
  it { is_expected.to respond_to(:goals_conceded) }
  it { is_expected.to respond_to(:rating) }
  it { is_expected.to respond_to(:points) }

  describe '#goals' do
    specify { expect(subject.goals).to eq 0 }
  end
  
  describe '#goal_assists' do
    specify { expect(subject.goal_assists).to eq 0 }
  end

  describe '#own_goals' do
    specify { expect(subject.own_goals).to eq 0 }
  end
  
  describe '#goals_conceded' do
    specify { expect(subject.goals_conceded).to eq 0 }
  end

  describe '#rating' do
    specify { expect(subject.rating).to eq 0 }
  end

  describe '#points' do
    specify { expect(subject.points).to eq 0 }
  end


  # All these should be valid since a reset and summary should be done in before_validation
  context "when goals is nil" do
    before { subject.goals = nil }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when goals is invalid" do
    before { subject.goals = -1 }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end
  
  context "when goal_assists is nil" do
    before { subject.goal_assists = nil }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when goal_assists is invalid" do
    before { subject.goal_assists = -1 }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end
  
  context "when own_goals is nil" do
    before { subject.own_goals = nil }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when own_goals is invalid" do
    before { subject.own_goals = -1 }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end
  
  context "when goals_conceded is nil" do
    before { subject.goals_conceded = nil }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when goals_conceded is invalid" do
    before { subject.goals_conceded = -1 }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when rating is nil" do
    before { subject.rating = nil }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when rating is invalid" do
    before { subject.rating = -1 }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end

  context "when points is nil" do
    before { subject.points = nil }
    it("if reset",if: reset) { is_expected.to be_valid }
    it("if not reset",if: !reset) { is_expected.not_to be_valid }
  end
  
end