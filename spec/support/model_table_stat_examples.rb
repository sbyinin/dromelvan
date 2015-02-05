shared_examples_for "table stat" do

  it { is_expected.to respond_to(:matches_played) }
  it { is_expected.to respond_to(:matches_won) }
  it { is_expected.to respond_to(:matches_drawn) }
  it { is_expected.to respond_to(:matches_lost) }
  it { is_expected.to respond_to(:goals_for) }
  it { is_expected.to respond_to(:goals_against) }
  it { is_expected.to respond_to(:goal_difference) }
  it { is_expected.to respond_to(:points) }
  it { is_expected.to respond_to(:ranking) }
  it { is_expected.to respond_to(:home_matches_played) }
  it { is_expected.to respond_to(:home_matches_won) }
  it { is_expected.to respond_to(:home_matches_drawn) }
  it { is_expected.to respond_to(:home_matches_lost) }
  it { is_expected.to respond_to(:home_goals_for) }
  it { is_expected.to respond_to(:home_goals_against) }
  it { is_expected.to respond_to(:home_goal_difference) }
  it { is_expected.to respond_to(:home_points) }
  it { is_expected.to respond_to(:home_ranking) }
  it { is_expected.to respond_to(:away_matches_played) }
  it { is_expected.to respond_to(:away_matches_won) }
  it { is_expected.to respond_to(:away_matches_drawn) }
  it { is_expected.to respond_to(:away_matches_lost) }
  it { is_expected.to respond_to(:away_goals_for) }
  it { is_expected.to respond_to(:away_goals_against) }
  it { is_expected.to respond_to(:away_goal_difference) }
  it { is_expected.to respond_to(:away_points) }
  it { is_expected.to respond_to(:away_ranking) }
  it { is_expected.to respond_to(:date) }
  
  it { is_expected.to be_valid }
  
  describe '#matches_played' do
    specify { expect(subject.matches_played).to eq 0 } 
  end
  
  describe '#matches_won' do
    specify { expect(subject.matches_won).to eq 0 } 
  end

  describe '#matches_drawn' do
    specify { expect(subject.matches_drawn).to eq 0 } 
  end

  describe '#matches_lost' do
    specify { expect(subject.matches_lost).to eq 0 } 
  end

  describe '#goals_for' do
    specify { expect(subject.goals_for).to eq 0 } 
  end

  describe '#goals_against' do
    specify { expect(subject.goals_against).to eq 0 } 
  end

  describe '#goal_difference' do
    specify { expect(subject.goal_difference).to eq 0 } 
  end

  describe '#points' do
    specify { expect(subject.points).to eq 0 } 
  end

  describe '#ranking' do
    specify { expect(subject.ranking).to eq 0 } 
  end

  describe '#home_matches_played' do
    specify { expect(subject.home_matches_played).to eq 0 } 
  end
  
  describe '#home_matches_won' do
    specify { expect(subject.home_matches_won).to eq 0 } 
  end

  describe '#home_matches_drawn' do
    specify { expect(subject.home_matches_drawn).to eq 0 } 
  end

  describe '#home_matches_lost' do
    specify { expect(subject.home_matches_lost).to eq 0 } 
  end

  describe '#home_goals_for' do
    specify { expect(subject.home_goals_for).to eq 0 } 
  end

  describe '#home_goals_against' do
    specify { expect(subject.home_goals_against).to eq 0 } 
  end

  describe '#home_goal_difference' do
    specify { expect(subject.home_goal_difference).to eq 0 } 
  end

  describe '#home_points' do
    specify { expect(subject.home_points).to eq 0 } 
  end

  describe '#home_ranking' do
    specify { expect(subject.home_ranking).to eq 0 } 
  end

  describe '#away_matches_played' do
    specify { expect(subject.away_matches_played).to eq 0 } 
  end
  
  describe '#away_matches_won' do
    specify { expect(subject.away_matches_won).to eq 0 } 
  end

  describe '#away_matches_drawn' do
    specify { expect(subject.away_matches_drawn).to eq 0 } 
  end

  describe '#away_matches_lost' do
    specify { expect(subject.away_matches_lost).to eq 0 } 
  end

  describe '#away_goals_for' do
    specify { expect(subject.away_goals_for).to eq 0 } 
  end

  describe '#away_goals_against' do
    specify { expect(subject.away_goals_against).to eq 0 } 
  end

  describe '#away_goal_difference' do
    specify { expect(subject.away_goal_difference).to eq 0 } 
  end

  describe '#away_points' do
    specify { expect(subject.away_points).to eq 0 } 
  end

  describe '#away_ranking' do
    specify { expect(subject.away_ranking).to eq 0 } 
  end

  describe '#date' do
    specify { expect(subject.date).to eq subject.read_association("([a-z0-9]*_)?match_day").date } 
  end 



  context "when matches_played is nil" do
    before { subject.matches_played = nil }
    it { is_expected.to be_valid }
  end

  context "when matches_played is invalid" do
    before { subject.matches_played = -1 }
    it { is_expected.to be_valid }
  end
  
  context "when matches_won is nil" do
    before { subject.matches_won = nil }
    it { is_expected.to be_valid }
  end

  context "when matches_won is invalid" do
    before { subject.matches_won = -1 }
    it { is_expected.to be_valid }
  end

  context "when matches_drawn is nil" do
    before { subject.matches_drawn = nil }
    it { is_expected.to be_valid }
  end

  context "when matches_drawn is invalid" do
    before { subject.matches_drawn = -1 }
    it { is_expected.to be_valid }
  end

  context "when matches_lost is nil" do
    before { subject.matches_lost = nil }
    it { is_expected.to be_valid }
  end

  context "when matches_lost is invalid" do
    before { subject.matches_lost = -1 }
    it { is_expected.to be_valid }
  end

  context "when goals_for is nil" do
    before { subject.goals_for = nil }
    it { is_expected.to be_valid }
  end

  context "when goals_for is invalid" do
    before { subject.goals_for = -1 }
    it { is_expected.to be_valid }
  end

  context "when goals_against is nil" do
    before { subject.goals_against = nil }
    it { is_expected.to be_valid }
  end

  context "when goals_against is invalid" do
    before { subject.goals_against = -1 }
    it { is_expected.to be_valid }
  end
  
  context "when goal_difference is nil" do
    before { subject.goal_difference = nil }
    it { is_expected.to be_valid }
  end

  context "when goal_difference is invalid" do
    before { subject.goal_difference = 0.5 }
    it { is_expected.to be_valid }
  end
  
  context "when points is nil" do
    before { subject.points = nil }
    it { is_expected.to be_valid }
  end

  context "when points is invalid" do
    before { subject.points = -1 }
    it { is_expected.to be_valid }
  end

  context "when ranking is nil" do
    before { subject.ranking = nil }
    it { is_expected.to be_valid }
  end

  context "when ranking is invalid" do
    before { subject.ranking = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when home_matches_played is nil" do
    before { subject.home_matches_played = nil }
    it { is_expected.to be_valid }
  end

  context "when home_matches_played is invalid" do
    before { subject.home_matches_played = -1 }
    it { is_expected.to be_valid }
  end
  
  context "when home_matches_won is nil" do
    before { subject.home_matches_won = nil }
    it { is_expected.to be_valid }
  end

  context "when home_matches_won is invalid" do
    before { subject.home_matches_won = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when home_matches_drawn is nil" do
    before { subject.home_matches_drawn = nil }
    it { is_expected.to be_valid }
  end

  context "when home_matches_drawn is invalid" do
    before { subject.home_matches_drawn = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when home_matches_lost is nil" do
    before { subject.home_matches_lost = nil }
    it { is_expected.to be_valid }
  end

  context "when home_matches_lost is invalid" do
    before { subject.home_matches_lost = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when home_goals_for is nil" do
    before { subject.home_goals_for = nil }
    it { is_expected.to be_valid }
  end

  context "when home_goals_for is invalid" do
    before { subject.home_goals_for = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when home_goals_against is nil" do
    before { subject.home_goals_against = nil }
    it { is_expected.to be_valid }
  end

  context "when home_goals_against is invalid" do
    before { subject.home_goals_against = -1 }
    it { is_expected.not_to be_valid }
  end
  
  context "when home_goal_difference is nil" do
    before { subject.home_goal_difference = nil }
    it { is_expected.to be_valid }
  end

  context "when home_goal_difference is invalid" do
    before { subject.home_goal_difference = 0.5 }
    it { is_expected.to be_valid }
  end
  
  context "when home_points is nil" do
    before { subject.home_points = nil }
    it { is_expected.to be_valid }
  end

  context "when home_points is invalid" do
    before { subject.home_points = -1 }
    it { is_expected.to be_valid }
  end

  context "when home_ranking is nil" do
    before { subject.home_ranking = nil }
    it { is_expected.to be_valid }
  end

  context "when home_ranking is invalid" do
    before { subject.home_ranking = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when away_matches_played is nil" do
    before { subject.away_matches_played = nil }
    it { is_expected.to be_valid }
  end

  context "when away_matches_played is invalid" do
    before { subject.away_matches_played = -1 }
    it { is_expected.to be_valid }
  end
  
  context "when away_matches_won is nil" do
    before { subject.away_matches_won = nil }
    it { is_expected.to be_valid }
  end

  context "when away_matches_won is invalid" do
    before { subject.away_matches_won = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when away_matches_drawn is nil" do
    before { subject.away_matches_drawn = nil }
    it { is_expected.to be_valid }
  end

  context "when away_matches_drawn is invalid" do
    before { subject.away_matches_drawn = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when away_matches_lost is nil" do
    before { subject.away_matches_lost = nil }
    it { is_expected.to be_valid }
  end

  context "when away_matches_lost is invalid" do
    before { subject.away_matches_lost = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when away_goals_for is nil" do
    before { subject.away_goals_for = nil }
    it { is_expected.to be_valid }
  end

  context "when away_goals_for is invalid" do
    before { subject.away_goals_for = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when away_goals_against is nil" do
    before { subject.away_goals_against = nil }
    it { is_expected.to be_valid }
  end

  context "when away_goals_against is invalid" do
    before { subject.away_goals_against = -1 }
    it { is_expected.not_to be_valid }
  end
  
  context "when away_goal_difference is nil" do
    before { subject.away_goal_difference = nil }
    it { is_expected.to be_valid }
  end

  context "when away_goal_difference is invalid" do
    before { subject.away_goal_difference = 0.5 }
    it { is_expected.to be_valid }
  end
  
  context "when away_points is nil" do
    before { subject.away_points = nil }
    it { is_expected.to be_valid }
  end

  context "when away_points is invalid" do
    before { subject.away_points = -1 }
    it { is_expected.to be_valid }
  end

  context "when away_ranking is nil" do
    before { subject.away_ranking = nil }
    it { is_expected.to be_valid }
  end

  context "when away_ranking is invalid" do
    before { subject.away_ranking = -1 }
    it { is_expected.not_to be_valid }
  end
  
#  describe "default scope order" do
#    
#    before do
#      subject.class.destroy_all
#    end
#    
#    let!(:match_event1) { FactoryGirl.create(subject.class, time: 45, added_time: 4) }
#    let!(:match_event2) { FactoryGirl.create(subject.class, time: 30) }
#    let!(:match_event3) { FactoryGirl.create(subject.class, time: 90, added_time: 1) }
#    let!(:match_event4) { FactoryGirl.create(subject.class, time: 45, added_time: 2) }
#    let!(:match_event5) { FactoryGirl.create(subject.class, time: 90, added_time: 3) }
#    let!(:match_event6) { FactoryGirl.create(subject.class, time: 46) }
#    let!(:match_event7) { FactoryGirl.create(subject.class, time: 45) }
#        
#    specify { expect(subject.class.all).to eq [ match_event2, match_event7, match_event4, match_event1, match_event6, match_event3, match_event5 ] }    
#  end
  
end