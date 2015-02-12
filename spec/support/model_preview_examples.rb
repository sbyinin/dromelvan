shared_examples_for "preview" do

  it { is_expected.to respond_to(:previous_meetings) }
  it { is_expected.to respond_to(:previous_meetings_count) }
  it { is_expected.to respond_to(:home_wins) }
  it { is_expected.to respond_to(:draws) }
  it { is_expected.to respond_to(:away_wins) }
  it { is_expected.to respond_to(:home_goals) }
  it { is_expected.to respond_to(:away_goals) }
  it { is_expected.to respond_to(:home_win_percentage) }
  it { is_expected.to respond_to(:draw_percentage) }
  it { is_expected.to respond_to(:away_win_percentage) }
  it { is_expected.to respond_to(:home_yellow_cards) }
  it { is_expected.to respond_to(:home_red_cards) }
  it { is_expected.to respond_to(:away_yellow_cards) }
  it { is_expected.to respond_to(:away_red_cards) }
  
  describe '#previous_meetings_count' do
    specify { expect(subject.previous_meetings_count).to eq 4 } 
  end 

  describe '#home_wins' do
    specify { expect(subject.home_wins).to eq 1 } 
  end 

  describe '#draws' do
    specify { expect(subject.draws).to eq 1 } 
  end 
  
  describe '#away_wins' do
    specify { expect(subject.away_wins).to eq 2 } 
  end 

  describe '#home_goals' do
    specify { expect(subject.home_goals).to eq 7 } 
  end 

  describe '#away_goals' do
    specify { expect(subject.away_goals).to eq 8 } 
  end 

  describe '#home_win_percentage' do
    specify { expect(subject.home_win_percentage).to eq 25 } 
  end 

  describe '#draw_percentage' do
    specify { expect(subject.draw_percentage).to eq 25 } 
  end 
  
  describe '#away_win_percentage' do
    specify { expect(subject.away_win_percentage).to eq 50 } 
  end 

  describe '#home_yellow_cards' do
    specify { expect(subject.home_yellow_cards).to eq 1 } 
  end
  
  describe '#away_yellow_cards' do
    specify { expect(subject.away_yellow_cards).to eq 3 } 
  end 

  describe '#home_red_cards' do
    specify { expect(subject.home_red_cards).to eq 1 } 
  end
  
  describe '#away_red_cards' do
    specify { expect(subject.away_red_cards).to eq 2 } 
  end 

  context "when previous meetings don't exist" do
    let(:first_meeting) { FactoryGirl.create(subject.class.name.delete("Preview").underscore.to_sym) }    
    let(:preview) { subject.class.new(subject.class.name.delete("Preview").underscore.to_sym => first_meeting) }
    
    specify { expect(preview.previous_meetings).to eq [] }
    specify { expect(preview.previous_meetings_count).to eq 0 }
    specify { expect(preview.home_wins).to eq 0 }
    specify { expect(preview.draws).to eq 0 }
    specify { expect(preview.away_wins).to eq 0 }
    specify { expect(preview.home_goals).to eq 0 }
    specify { expect(preview.away_goals).to eq 0 }
    specify { expect(preview.home_win_percentage).to eq 0 }
    specify { expect(preview.draw_percentage).to eq 0 } 
    specify { expect(preview.away_win_percentage).to eq 0 }
    specify { expect(preview.home_yellow_cards).to eq 0 }
    specify { expect(preview.away_yellow_cards).to eq 0 }
    specify { expect(preview.home_red_cards).to eq 0 }
    specify { expect(preview.away_red_cards).to eq 0 }     
  end

end