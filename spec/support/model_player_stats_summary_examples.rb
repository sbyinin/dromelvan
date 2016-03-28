shared_examples_for "player stats summary" do
  
  it_should_behave_like "player stats", true
  
  it { is_expected.to respond_to(:clean_sheets) }
  it { is_expected.to respond_to(:yellow_cards) }
  it { is_expected.to respond_to(:red_cards) }
  it { is_expected.to respond_to(:man_of_the_match) }
  it { is_expected.to respond_to(:shared_man_of_the_match) }
  it { is_expected.to respond_to(:games_started) }
  it { is_expected.to respond_to(:games_substitute) }
  it { is_expected.to respond_to(:games_did_not_participate) }
  it { is_expected.to respond_to(:appearances) }
  it { is_expected.to respond_to(:points_per_appearance) }
  it { is_expected.to respond_to(:points_per_appearance_s) }
  it { is_expected.to respond_to(:substitutions_on) }
  it { is_expected.to respond_to(:substitutions_off) }
  it { is_expected.to respond_to(:minutes_played) }
  it { is_expected.to respond_to(:reset) }
  it { is_expected.to respond_to(:player_match_stats) }

  describe '#clean_sheets' do
    specify { expect(subject.clean_sheets).to eq 0 }
  end

  describe '#yellow_cards' do
    specify { expect(subject.yellow_cards).to eq 0 }
  end

  describe '#red_cards' do
    specify { expect(subject.red_cards).to eq 0 }
  end

  describe '#man_of_the_match' do
    specify { expect(subject.man_of_the_match).to eq 0 }
  end

  describe '#shared_man_of_the_match' do
    specify { expect(subject.shared_man_of_the_match).to eq 0 }
  end

  describe '#games_started' do
    specify { expect(subject.games_started).to eq 0 }
  end

  describe '#games_substitute' do
    specify { expect(subject.games_substitute).to eq 0 }
  end

  describe '#games_did_not_participate' do
    specify { expect(subject.games_did_not_participate).to eq 0 }
  end

  describe '#appearances' do
    specify { expect(subject.appearances).to eq 0 }
  end

  describe '#points_per_appearance' do
    specify { expect(subject.points_per_appearance).to eq 0 }
  end

  describe '#substitutions_on' do
    specify { expect(subject.substitutions_on).to eq 0 }
  end

  describe '#substitutions_off' do
    specify { expect(subject.substitutions_off).to eq 0 }
  end

  describe '#minutes_played' do
    specify { expect(subject.minutes_played).to eq 0 }
  end

  describe '#reset' do
    before do
      subject.goals = 1
      subject.goal_assists = 1
      subject.own_goals = 1
      subject.goals_conceded = 1
      subject.rating = 1
      subject.points = 1                    
      subject.clean_sheets = 1
      subject.yellow_cards = 1
      subject.red_cards = 1
      subject.man_of_the_match = 1
      subject.shared_man_of_the_match = 1
      subject.games_started = 1
      subject.games_substitute = 1
      subject.games_did_not_participate = 1
      subject.points_per_appearance = 1
      subject.substitutions_on = 1
      subject.substitutions_off = 1
      subject.minutes_played = 1
      subject.reset
    end
    
    specify { expect(subject.goals).to eq 0 }
    specify { expect(subject.goal_assists).to eq 0 }
    specify { expect(subject.own_goals).to eq 0 }
    specify { expect(subject.goals_conceded).to eq 0 }
    specify { expect(subject.rating).to eq 0 }
    specify { expect(subject.points).to eq 0 }                    
    specify { expect(subject.clean_sheets).to eq 0 }
    specify { expect(subject.yellow_cards).to eq 0 }
    specify { expect(subject.red_cards).to eq 0 }
    specify { expect(subject.man_of_the_match).to eq 0 }
    specify { expect(subject.shared_man_of_the_match).to eq 0 }
    specify { expect(subject.games_started).to eq 0 }
    specify { expect(subject.games_substitute).to eq 0 }
    specify { expect(subject.games_did_not_participate).to eq 0 }
    specify { expect(subject.appearances).to eq 0 }
    specify { expect(subject.points_per_appearance).to eq 0 }
    specify { expect(subject.substitutions_on).to eq 0 }
    specify { expect(subject.substitutions_off).to eq 0 }
    specify { expect(subject.minutes_played).to eq 0 }                        
  end

  describe '#points_per_appearance_s' do
    specify { expect(subject.points_per_appearance_s).to eq '0.00' }
    
    context 'when points_per_appearance > 0' do
      before { subject.points_per_appearance = 123 }
      
      specify { expect(subject.points_per_appearance_s).to eq '1.23' }
    end    
  end

  # All these should be valid since a reset and summary should be done in before_validation
  context "when clean_sheets is nil" do
    before { subject.clean_sheets = nil }
    it { is_expected.to be_valid }
  end

  context "when clean_sheets is invalid" do
    before { subject.clean_sheets = -1 }
    it { is_expected.to be_valid }
  end

  context "when yellow_cards is nil" do
    before { subject.yellow_cards = nil }
    it { is_expected.to be_valid }
  end

  context "when yellow_cards is invalid" do
    before { subject.yellow_cards = -1 }
    it { is_expected.to be_valid }
  end

  context "when red_cards is nil" do
    before { subject.red_cards = nil }
    it { is_expected.to be_valid }
  end

  context "when red_cards is invalid" do
    before { subject.red_cards = -1 }
    it { is_expected.to be_valid }
  end

  context "when man_of_the_match is nil" do
    before { subject.man_of_the_match = nil }
    it { is_expected.to be_valid }
  end

  context "when man_of_the_match is invalid" do
    before { subject.man_of_the_match = -1 }
    it { is_expected.to be_valid }
  end

  context "when shared_man_of_the_match is nil" do
    before { subject.shared_man_of_the_match = nil }
    it { is_expected.to be_valid }
  end

  context "when shared_man_of_the_match is invalid" do
    before { subject.shared_man_of_the_match = -1 }
    it { is_expected.to be_valid }
  end

  context "when games_started is nil" do
    before { subject.games_started = nil }
    it { is_expected.to be_valid }
  end

  context "when games_started is invalid" do
    before { subject.games_started = -1 }
    it { is_expected.to be_valid }
  end

  context "when games_substitute is nil" do
    before { subject.games_substitute = nil }
    it { is_expected.to be_valid }
  end

  context "when games_substitute is invalid" do
    before { subject.games_substitute = -1 }
    it { is_expected.to be_valid }
  end

  context "when games_did_not_participate is nil" do
    before { subject.games_did_not_participate = nil }
    it { is_expected.to be_valid }
  end

  context "when games_did_not_participate is invalid" do
    before { subject.games_did_not_participate = -1 }
    it { is_expected.to be_valid }
  end

  context "when points_per_appearance is nil" do
    before { subject.points_per_appearance = nil }
    it { is_expected.to be_valid }
  end

  context "when substitutions_on is nil" do
    before { subject.substitutions_on = nil }
    it { is_expected.to be_valid }
  end

  context "when substitutions_on is invalid" do
    before { subject.substitutions_on = -1 }
    it { is_expected.to be_valid }
  end

  context "when substitutions_off is nil" do
    before { subject.substitutions_off = nil }
    it { is_expected.to be_valid }
  end

  context "when substitutions_off is invalid" do
    before { subject.substitutions_off = -1 }
    it { is_expected.to be_valid }
  end

  context "when minutes_played is nil" do
    before { subject.minutes_played = nil }
    it { is_expected.to be_valid }
  end

  context "when minutes_played is invalid" do
    before { subject.minutes_played = -1 }
    it { is_expected.to be_valid }
  end
    
end