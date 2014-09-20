require 'rails_helper'

describe Match, type: :model do
  
  let(:home_team) { FactoryGirl.create(:team) }
  let(:away_team) { FactoryGirl.create(:team) }
  let(:match_day) { FactoryGirl.create(:match_day) }
  let(:stadium) { FactoryGirl.create(:stadium) }
  let(:datetime) { DateTime.now }
  
  before { @match = FactoryGirl.create(:match, home_team: home_team, away_team: away_team, match_day: match_day, stadium: stadium, home_team_goals: 1, away_team_goals: 2, datetime: datetime, elapsed: "FT", status: 2, whoscored_id: 1) }
  
  subject { @match }
  
  it { is_expected.to respond_to(:home_team) }
  it { is_expected.to respond_to(:away_team) }
  it { is_expected.to respond_to(:match_day) }
  it { is_expected.to respond_to(:stadium) }
  it { is_expected.to respond_to(:home_team_goals) }
  it { is_expected.to respond_to(:away_team_goals) }
  it { is_expected.to respond_to(:datetime) }
  it { is_expected.to respond_to(:elapsed) }
  it { is_expected.to respond_to(:status) }
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

  describe '#elapsed' do
    subject { @match.elapsed }
    it { is_expected.to eq "FT" }
  end

  describe '#status' do
    subject { @match.status }
    it { is_expected.to eq 2 }
  end

  describe '#whoscored_id' do
    subject { @match.whoscored_id }
    it { is_expected.to eq 1 }
  end

  describe '#name' do
    subject { @match.name }
    it { is_expected.to eq "#{ @match.home_team.name } vs #{ @match.away_team.name }" }
  end

  describe '#points' do
    describe "home_team" do
      subject { @match.points(home_team) }
      it { is_expected.to eq 0 }
    end
    
    describe '#away_team' do  
      subject { @match.points(away_team) }
      it { is_expected.to eq 3 }    
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

  describe '.match_dates' do
    let!(:tomorrow_match) { FactoryGirl.create(:match, datetime: DateTime.tomorrow) }
    let!(:yesterday_match) { FactoryGirl.create(:match, datetime: DateTime.yesterday) }      
      
    specify { expect(Match.match_dates).to eq [ yesterday_match.datetime.to_date, @match.datetime.to_date, tomorrow_match.datetime.to_date ] }
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

  context "when status is nil" do
    before { @match.status = nil }
    it { is_expected.not_to be_valid }
  end

  context "when status is invalid" do
    before { @match.status = 3 }
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

  describe "default scope order" do
    before { Match.destroy_all }
    
    let!(:match1) { FactoryGirl.create(:match, datetime: DateTime.now) }
    let!(:match2) { FactoryGirl.create(:match, datetime: DateTime.now - 1.day) }
   
    specify { expect(Match.all).to eq [ match2, match1 ] }
  end

  describe "season scope" do
    let!(:match1) { FactoryGirl.create(:match) }
    let!(:match2) { FactoryGirl.create(:match) }
    
    specify { expect(Match.by_seasons.where(seasons: {id: match1.match_day.premier_league.season.id})).to eq [ match1 ] }
    specify { expect(Match.by_seasons.where(seasons: {id: match2.match_day.premier_league.season.id})).to eq [ match2 ] }
  end
end
