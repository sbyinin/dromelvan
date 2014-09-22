shared_examples_for "match event" do

  it { is_expected.to respond_to(:match) }
  it { is_expected.to respond_to(:team) }
  it { is_expected.to respond_to(:player) }
  it { is_expected.to respond_to(:time) }
  it { is_expected.to respond_to(:added_time) }
  
  describe '#match' do
    subject { match_event.match }
    it { is_expected.to eq match }
  end

  describe '#team' do
    subject { match_event.team }
    it { is_expected.to eq team }
  end
  
  describe '#player' do
    subject { match_event.player }
    it { is_expected.to eq player }
  end

  describe '#time' do
    subject { match_event.time }
    it { is_expected.to eq time }
  end
  
  describe '#added_time' do
    subject { match_event.added_time }
    it { is_expected.to eq added_time }
  end
  
  context "when match is nil" do
    before { match_event.match = nil }
    it { is_expected.not_to be_valid }
  end

  context "when team is nil" do
    before { match_event.team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when player is nil" do
    before { match_event.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when time is nil" do
    before { match_event.time = nil }
    it { is_expected.not_to be_valid }
  end

  context "when time is invalid" do
    before { match_event.time = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when added_time is nil" do
    before { match_event.added_time = nil }
    it { is_expected.not_to be_valid }
  end

  context "when added_time is invalid" do
    before { match_event.added_time = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when time, added_time is valid" do
    before do
      match_event.time = 45
      match_event.added_time = 1
    end
    it { is_expected.to be_valid }
  end

  context "when time, added_time is invalid" do
    before do
      match_event.time = 46
      match_event.added_time = 1
    end
    it { is_expected.not_to be_valid }
  end
  
  
  describe "default scope order" do
    
    before do
      subject.class.destroy_all
    end
    
    let!(:match_event1) { FactoryGirl.create(subject.class, time: 45, added_time: 4) }
    let!(:match_event2) { FactoryGirl.create(subject.class, time: 30) }
    let!(:match_event3) { FactoryGirl.create(subject.class, time: 90, added_time: 1) }
    let!(:match_event4) { FactoryGirl.create(subject.class, time: 45, added_time: 2) }
    let!(:match_event5) { FactoryGirl.create(subject.class, time: 90, added_time: 3) }
    let!(:match_event6) { FactoryGirl.create(subject.class, time: 46) }
    let!(:match_event7) { FactoryGirl.create(subject.class, time: 45) }
        
    specify { expect(subject.class.all).to eq [ match_event2, match_event7, match_event4, match_event1, match_event6, match_event3, match_event5 ] }    
  end
  
end