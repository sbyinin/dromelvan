require 'rails_helper'

describe D11Match, type: :model do
  let(:home_d11_team) { FactoryGirl.create(:d11_team) }
  let(:away_d11_team) { FactoryGirl.create(:d11_team) }
  let(:match_day) { FactoryGirl.create(:match_day, status: :finished) }
  let(:d11_match_day) { FactoryGirl.create(:d11_match_day, match_day: match_day) }
  
  before { @d11_match = FactoryGirl.create(:d11_match, home_d11_team: home_d11_team, away_d11_team: away_d11_team, d11_match_day: d11_match_day, home_team_points: 5, away_team_points: 10, status: :finished) }
  
  subject { @d11_match }

  it { is_expected.to respond_to(:home_d11_team) }
  it { is_expected.to respond_to(:away_d11_team) }
  it { is_expected.to respond_to(:d11_match_day) }
  it { is_expected.to respond_to(:home_team_goals) }
  it { is_expected.to respond_to(:away_team_goals) }
  it { is_expected.to respond_to(:home_team_points) }
  it { is_expected.to respond_to(:away_team_points) }
  it { is_expected.to respond_to(:elapsed) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:pending?) }
  it { is_expected.to respond_to(:active?) }
  it { is_expected.to respond_to(:finished?) }
  
  it { is_expected.to be_valid }
    
  describe '#home_d11_team' do
    subject { @d11_match.home_d11_team }
    it { is_expected.to eq home_d11_team }
  end
    
  describe '#away_d11_team' do
    subject { @d11_match.away_d11_team }
    it { is_expected.to eq away_d11_team }
  end
    
  describe '#d11_match_day' do
    subject { @d11_match.d11_match_day }
    it { is_expected.to eq d11_match_day }
  end
    
  describe '#home_team_goals' do
    subject { @d11_match.home_team_goals }
    it { is_expected.to eq 2 }
  end

  describe '#away_team_goals' do
    subject { @d11_match.away_team_goals }
    it { is_expected.to eq 3 }
  end

  describe '#home_team_points' do
    subject { @d11_match.home_team_points }
    it { is_expected.to eq 5 }
  end

  describe '#away_team_points' do
    subject { @d11_match.away_team_points }
    it { is_expected.to eq 10 }
  end

  describe '#status' do
    subject { @d11_match.status }
    it { is_expected.to eq :finished.to_s }
  end    
    
  describe '#elapsed' do
    subject { @d11_match.elapsed }
    it { is_expected.to eq "FT" }
  end
    
  describe '#pending?' do
    subject { @d11_match.pending? }
    it { is_expected.to eq false }
  end

  describe '#active?' do
    subject { @d11_match.active? }
    it { is_expected.to eq false }
  end
    
  describe '#finished?' do
    subject { @d11_match.finished? }
    it { is_expected.to eq true }
  end
    
  describe '#name' do
    subject { @d11_match.name }
    it { is_expected.to eq "#{ @d11_match.home_d11_team.name } vs #{ @d11_match.away_d11_team.name }" }
  end


  describe "#result and points" do    
    context "when home_d11_team wins" do
      before do
        @d11_match.home_team_points = 5
        @d11_match.away_team_points = 0
      end
      
      specify { expect(@d11_match.result(@d11_match.home_d11_team)).to eq :win }
      specify { expect(@d11_match.result(@d11_match.away_d11_team)).to eq :loss }            
      specify { expect(@d11_match.points(@d11_match.home_d11_team)).to eq 3 }
      specify { expect(@d11_match.points(@d11_match.away_d11_team)).to eq 0 }
    end
    
    context "when away_d11_team wins" do
      before do
        @d11_match.home_team_points = 0
        @d11_match.away_team_points = 5
      end

      specify { expect(@d11_match.result(@d11_match.home_d11_team)).to eq :loss }
      specify { expect(@d11_match.result(@d11_match.away_d11_team)).to eq :win }                  
      specify { expect(@d11_match.points(@d11_match.home_d11_team)).to eq 0 }
      specify { expect(@d11_match.points(@d11_match.away_d11_team)).to eq 3 }
    end
    
    context "for a draw" do
      before do
        @d11_match.home_team_points = 5
        @d11_match.away_team_points = 5
      end
      
      specify { expect(@d11_match.result(@d11_match.home_d11_team)).to eq :draw }
      specify { expect(@d11_match.result(@d11_match.away_d11_team)).to eq :draw }                  
      specify { expect(@d11_match.points(@d11_match.home_d11_team)).to eq 1 }
      specify { expect(@d11_match.points(@d11_match.away_d11_team)).to eq 1 }
    end    
  end

  describe '#goals_for' do
    describe "home_d11_team" do
      subject { @d11_match.goals_for(home_d11_team) }
      it { is_expected.to eq 2 }
    end
    
    describe '#away_d11_team' do  
      subject { @d11_match.goals_for(away_d11_team) }
      it { is_expected.to eq 3 }    
    end    
  end
  
  describe '#goals_against' do
    describe "home_d11_team" do
      subject { @d11_match.goals_against(home_d11_team) }
      it { is_expected.to eq 3 }
    end
    
    describe '#away_d11_team' do  
      subject { @d11_match.goals_against(away_d11_team) }
      it { is_expected.to eq 2 }    
    end    
  end
    
  describe '.by_season' do
    subject { D11Match.by_season(@d11_match.d11_match_day.d11_league.season) }
    it { is_expected.to eq [ @d11_match ] }
  end

  describe '.by_d11_team' do
    describe "home_d11_team" do
      subject { D11Match.by_d11_team(@d11_match.home_d11_team) }
      it { is_expected.to eq [ @d11_match ] }
    end
    
    describe "away_d11_team" do
      subject { D11Match.by_d11_team(@d11_match.away_d11_team) }
      it { is_expected.to eq [ @d11_match ] }
    end
    
    describe "non-d11-match team" do
      let(:d11_team) { FactoryGirl.create(:d11_team) }
      subject { D11Match.by_d11_team(d11_team) }
      it { is_expected.to eq [] }
    end    
  end

  describe '.by_date' do
    let!(:match_day) { FactoryGirl.create(:match_day) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, match_day: match_day) }
    let!(:match1) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 5.days) }
    let!(:match2) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 4.days) }
    let!(:match3) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 3.days) }
    let!(:match4) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 2.days) }
    let!(:match5) { FactoryGirl.create(:match, match_day: match_day, datetime: DateTime.now - 1.days) }
    let!(:d11_match1) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day) }
    let!(:d11_match2) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day) }
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, match: match1, d11_team: d11_match1.home_d11_team) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, match: match2, d11_team: d11_match1.away_d11_team) }
    let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, match: match3, d11_team: d11_match1.home_d11_team) }
    let!(:player_match_stat4) { FactoryGirl.create(:player_match_stat, match: match3, d11_team: d11_match2.away_d11_team) }
    let!(:player_match_stat5) { FactoryGirl.create(:player_match_stat, match: match4, d11_team: d11_match2.home_d11_team) }
    let!(:player_match_stat6) { FactoryGirl.create(:player_match_stat, match: match5, d11_team: d11_match2.away_d11_team) }
    
    specify { expect(d11_match_day.d11_matches.by_date(Date.today - 3.days)).to eq [ d11_match1 ] }
    specify { expect(d11_match_day.d11_matches.by_date(Date.today - 1.days)).to eq [ d11_match2 ] }
  end


  context "when home_d11_team is nil" do
    before { @d11_match.home_d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when away_d11_team is nil" do
    before { @d11_match.away_d11_team = nil }
    it { is_expected.not_to be_valid }
  end

  context "when d11_match_day is nil" do
    before { @d11_match.d11_match_day = nil }
    it { is_expected.not_to be_valid }
  end

  context "when home_team_goals is nil" do
    before { @d11_match.home_team_goals = nil }
    # Goals are updated in before_validate
    it { is_expected.to be_valid }
  end

  context "when home_team_goals is invalid" do
    before { @d11_match.home_team_goals = -1 }
    it { is_expected.to be_valid }
  end

  context "when away_team_goals is nil" do
    before { @d11_match.away_team_goals = nil }
    it { is_expected.to be_valid }
  end

  context "when away_team_goals is invalid" do
    before { @d11_match.home_team_goals = -1 }
    it { is_expected.to be_valid }
  end

  context "when home_team_points is nil" do
    # points are updated to 0 if they're nil before validation.    
    before { @d11_match.home_team_points = nil }
    it { is_expected.to be_valid }
  end

  context "when away_team_points is nil" do
    before { @d11_match.away_team_points = nil }
    it { is_expected.to be_valid }
  end

  context "when status is nil" do
    before { @d11_match.status = nil }
    it { is_expected.not_to be_valid }
  end  
    
  context "when elapsed is nil" do
    before { @d11_match.elapsed = nil }
    it { is_expected.to be_valid }
  end

  context "when match day status is active" do
    let!(:match_day) { FactoryGirl.create(:match_day, status: :active) }
    let!(:match1) { FactoryGirl.create(:match, match_day: match_day, status: :finished) }
    let!(:match2) { FactoryGirl.create(:match, match_day: match_day, status: :pending) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, match_day: match_day, match_day_number: match_day.match_day_number) }
    let!(:d11_match) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day)}
    let!(:d11_team_match_squad_stat1) { FactoryGirl.create(:d11_team_match_squad_stat, d11_match: d11_match, d11_team: d11_match.home_d11_team)}
    let!(:d11_team_match_squad_stat2) { FactoryGirl.create(:d11_team_match_squad_stat, d11_match: d11_match, d11_team: d11_match.away_d11_team)}
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, match: match1, d11_team: d11_match.home_d11_team) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, match: match2, d11_team: d11_match.home_d11_team) }
        
    before do
      d11_match.reload.valid?      
    end
    # 84 since 21 of 22 players are missing and therefore are not still to play.
    specify { expect(d11_match.elapsed).to eq "84" }
  end

  context "with d11_team_match_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_match) }
      let!(:dependent) { FactoryGirl.create(:d11_team_match_squad_stat, d11_match: owner) }      
    end
  end
    
  describe "default scope order" do
    before { D11Match.destroy_all }
    
    let(:d11_match_day1) { FactoryGirl.create(:d11_match_day, date: Date.today) }
    let(:d11_match_day2) { FactoryGirl.create(:d11_match_day, date: Date.today - 1) }
    let(:d11_match1) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day1) }
    let(:d11_match2) { FactoryGirl.create(:d11_match, d11_match_day: d11_match_day2) }
   
    specify { expect(D11Match.all).to eq [ d11_match2, d11_match1 ] }
  end

  describe "season scope" do
    let(:d11_match1) { FactoryGirl.create(:d11_match) }
    let(:d11_match2) { FactoryGirl.create(:d11_match) }
    
    specify { expect(D11Match.by_seasons.where(seasons: {id: d11_match1.d11_match_day.d11_league.season.id})).to eq [ d11_match1 ] }
    specify { expect(D11Match.by_seasons.where(seasons: {id: d11_match2.d11_match_day.d11_league.season.id})).to eq [ d11_match2 ] }
  end

end
