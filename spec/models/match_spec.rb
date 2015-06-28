require 'rails_helper'

describe Match, type: :model do
  
  let(:home_team) { FactoryGirl.create(:team) }
  let(:away_team) { FactoryGirl.create(:team) }
  let(:match_day) { FactoryGirl.create(:match_day) }
  let(:stadium) { FactoryGirl.create(:stadium) }
  let(:datetime) { DateTime.new(1970, 01, 01) }
  
  before { @match = FactoryGirl.create(:match, home_team: home_team, away_team: away_team, match_day: match_day, stadium: stadium, home_team_goals: 1, away_team_goals: 2, datetime: datetime, status: 2, whoscored_id: 1) }
  
  subject { @match }
  
  it { is_expected.to respond_to(:home_team) }
  it { is_expected.to respond_to(:away_team) }
  it { is_expected.to respond_to(:match_day) }
  it { is_expected.to respond_to(:stadium) }
  it { is_expected.to respond_to(:home_team_goals) }
  it { is_expected.to respond_to(:away_team_goals) }
  it { is_expected.to respond_to(:datetime) }
  it { is_expected.to respond_to(:postponed?) }
  it { is_expected.to respond_to(:postpone) }
  it { is_expected.to respond_to(:date_s) }
  it { is_expected.to respond_to(:short_date_s) }
  it { is_expected.to respond_to(:kickoff_time_s) }
  it { is_expected.to respond_to(:elapsed) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:pending?) }
  it { is_expected.to respond_to(:active?) }
  it { is_expected.to respond_to(:finished?) }  
  it { is_expected.to respond_to(:whoscored_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:points) }
  it { is_expected.to respond_to(:goals_for) }
  it { is_expected.to respond_to(:goals_against) }
  
  it { is_expected.to be_valid }
    
  describe '#home_team' do
    subject { @match.home_team }
    it { is_expected.to eq home_team }
  end
    
  describe '#away_team' do
    subject { @match.away_team }
    it { is_expected.to eq away_team }
  end
    
  describe '#match_day' do
    subject { @match.match_day }
    it { is_expected.to eq match_day }
  end
    
  describe '#stadium' do
    subject { @match.stadium }
    it { is_expected.to eq stadium }
  end

  describe '#home_team_goals' do
    subject { @match.home_team_goals }
    it { is_expected.to eq 1 }
  end

  describe '#away_team_goals' do
    subject { @match.away_team_goals }
    it { is_expected.to eq 2 }
  end

  describe '#datetime' do
    subject { @match.datetime }
    it { is_expected.to eq datetime }
  end

  describe '#postponed?' do
    subject { @match.postponed? }
    it { is_expected.to eq false }
    
    context 'when match is postponed' do
      before { @match.postpone }

      subject { @match.postponed? }
      it { is_expected.to eq true }
    end
  end

  describe '#date_s' do
    specify { expect(@match.date_s).to eq "Thursday, January 01 1970" }
    
    context 'when postponed' do
      before { @match.postpone }
      specify { expect(@match.date_s).to eq "Postponed" }
    end    
  end

  describe '#short_date_s' do
    specify { expect(@match.short_date_s).to eq "Thursday, 1.1 1970" }
    
    context 'when postponed' do
      before { @match.postpone }
      specify { expect(@match.short_date_s).to eq "Postponed" }
    end        
  end
  
  describe '#kickoff_time_s' do
    specify { expect(@match.kickoff_time_s).to eq "00:00" }
    
    context 'when postponed' do
      before { @match.postpone }
      specify { expect(@match.kickoff_time_s).to eq "PP" }
    end        
  end
  
  describe '#elapsed' do
    subject { @match.elapsed }
    it { is_expected.to eq "FT" }
  end

  describe '#status' do
    subject { @match.status }
    it { is_expected.to eq :finished.to_s }
  end

  describe '#pending?' do
    subject { @match.pending? }
    it { is_expected.to eq false }
  end

  describe '#active?' do
    subject { @match.active? }
    it { is_expected.to eq false }
  end
    
  describe '#finished?' do
    subject { @match.finished? }
    it { is_expected.to eq true }
  end

  describe '#whoscored_id' do
    subject { @match.whoscored_id }
    it { is_expected.to eq 1 }
  end

  describe '#name' do
    subject { @match.name }
    it { is_expected.to eq "#{ @match.home_team.name } vs #{ @match.away_team.name }" }
  end

  describe "#result and points" do
    context "when home_team wins" do
      before do
          @match.home_team_goals = 2
          @match.away_team_goals = 1      
      end

      specify { expect(@match.result(@match.home_team)).to eq :win }
      specify { expect(@match.result(@match.away_team)).to eq :loss }      
      specify { expect(@match.points(@match.home_team)).to eq 3 }
      specify { expect(@match.points(@match.away_team)).to eq 0 }
    end
    
    context "when away_team wins" do
      before do
        @match.home_team_goals = 1
        @match.away_team_goals = 2
      end

      specify { expect(@match.result(@match.home_team)).to eq :loss }
      specify { expect(@match.result(@match.away_team)).to eq :win }            
      specify { expect(@match.points(@match.home_team)).to eq 0 }
      specify { expect(@match.points(@match.away_team)).to eq 3 }
    end
    
    context "for a draw" do
      before do
        @match.home_team_goals = 2
        @match.away_team_goals = 2
      end
      
      specify { expect(@match.result(@match.home_team)).to eq :draw }
      specify { expect(@match.result(@match.away_team)).to eq :draw }            
      specify { expect(@match.points(@match.home_team)).to eq 1 }
      specify { expect(@match.points(@match.away_team)).to eq 1 }
    end    
  end

  describe '#goals_for' do
    describe "home_team" do
      subject { @match.goals_for(home_team) }
      it { is_expected.to eq 1 }
    end
    
    describe '#away_team' do  
      subject { @match.goals_for(away_team) }
      it { is_expected.to eq 2 }    
    end    
  end
  
  describe '#goals_against' do
    describe "home_team" do
      subject { @match.goals_against(home_team) }
      it { is_expected.to eq 2 }
    end
    
    describe '#away_team' do  
      subject { @match.goals_against(away_team) }
      it { is_expected.to eq 1 }    
    end    
  end

  
  describe '.by_season' do
    subject { Match.by_season(@match.match_day.premier_league.season) }
    it { is_expected.to eq [ @match ] }
  end

  describe '.by_team' do
    describe "home_team" do
      subject { Match.by_team(@match.home_team) }
      it { is_expected.to eq [ @match ] }
    end
    
    describe "away_team" do
      subject { Match.by_team(@match.away_team) }
      it { is_expected.to eq [ @match ] }
    end
    
    describe "non-match team" do
      let(:team) { FactoryGirl.create(:team) }
      subject { Match.by_team(team) }
      it { is_expected.to eq [] }
    end    
  end

  describe '.by_date' do
    subject { Match.by_date(@match.datetime) }
    it { is_expected.to eq [ @match ] }
  end


  context "when home_team is nil" do
    before { @match.home_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when away_team is nil" do
    before { @match.away_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match_day is nil" do
    before { @match.match_day = nil }
    it { is_expected.not_to be_valid }
  end

  context "when stadium is nil" do
    before { @match.stadium = nil }
    it { is_expected.not_to be_valid }
  end

  context "when home_team_goals is nil" do
    before { @match.home_team_goals = nil }
    it { is_expected.not_to be_valid }
  end

  context "when home_team_goals is invalid" do
    before { @match.home_team_goals = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when away_team_goals is nil" do
    before { @match.away_team_goals = nil }
    it { is_expected.not_to be_valid }
  end

  context "when away_team_goals is invalid" do
    before { @match.home_team_goals = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when datetime is nil" do
    before { @match.datetime = nil }
    it { is_expected.not_to be_valid }
  end

  context "when elapsed is nil" do
    # Elapsed is set before validation if status is pending or finished.
    before { @match.elapsed = nil }
    it { is_expected.to be_valid }
  end

  context "when elapsed is nil and status is 1" do
    # Elapsed is set before validation if status is pending or finished.
    before do
      @match.status = 1
      @match.elapsed = nil
    end
    
    it { is_expected.not_to be_valid }
  end

  context "when status is nil" do
    before { @match.status = nil }
    it { is_expected.not_to be_valid }
  end

  context "when whoscored_id is nil" do
    before { @match.whoscored_id = nil }
    it { is_expected.not_to be_valid }
  end

  context "when whoscored_id is invalid" do
    before { @match.whoscored_id = -1 }
    it { is_expected.not_to be_valid }
  end

  context "with player_match_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:match) }
      let!(:dependent) { FactoryGirl.create(:player_match_stat, match: owner) }      
    end
  end
  
  context "with goal dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:match) }
      let!(:dependent) { FactoryGirl.create(:goal, match: owner) }      
    end
  end

  context "with card dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:match) }
      let!(:dependent) { FactoryGirl.create(:card, match: owner) }      
    end
  end

  context "with substitution dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:match) }
      let!(:dependent) { FactoryGirl.create(:substitution, match: owner) }      
    end
  end

  context "with team_match_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:match) }
      let!(:dependent) { FactoryGirl.create(:team_match_squad_stat, match: owner) }      
    end
  end

  describe "default scope order" do
    before { Match.destroy_all }
    
    let(:match1) { FactoryGirl.create(:match, datetime: DateTime.now) }
    let(:match2) { FactoryGirl.create(:match, datetime: DateTime.now - 1.day) }
   
    specify { expect(Match.all).to eq [ match2, match1 ] }
  end

  describe "season scope" do
    let(:match1) { FactoryGirl.create(:match) }
    let(:match2) { FactoryGirl.create(:match) }
    
    specify { expect(Match.by_seasons.where(seasons: {id: match1.match_day.premier_league.season.id})).to eq [ match1 ] }
    specify { expect(Match.by_seasons.where(seasons: {id: match2.match_day.premier_league.season.id})).to eq [ match2 ] }
  end
  
end
