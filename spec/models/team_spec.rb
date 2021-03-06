require 'rails_helper'

describe Team, type: :model do
  
  let(:stadium) { FactoryGirl.create(:stadium) }
  
  before { @team = FactoryGirl.create(:team, stadium: stadium, whoscored_id: 1, name: "Test Team", code: "TTM", nickname: "Test Nickname", established: 1900, motto: "Test Motto", colour: "#FFFFFF") }
  
  subject { @team }

  it { is_expected.to respond_to(:stadium) }
  it { is_expected.to respond_to(:whoscored_id) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:nickname) }
  it { is_expected.to respond_to(:established) }
  it { is_expected.to respond_to(:motto) }
  it { is_expected.to respond_to(:colour) }
  it { is_expected.to respond_to(:dummy) }
  it { is_expected.to respond_to(:club_crest) }

  it { is_expected.to be_valid }

  describe '#stadium' do
    subject { @team.stadium }
    it { is_expected.to eq stadium }
  end

  describe '#whoscored_id' do
    subject { @team.whoscored_id }
    it { is_expected.to eq 1 }
  end

  describe '#name' do
    subject { @team.name }
    it { is_expected.to eq "Test Team" }
  end

  describe '#code' do
    subject { @team.code }
    it { is_expected.to eq "TTM" }
  end

  describe '#nickname' do
    subject { @team.nickname }
    it { is_expected.to eq "Test Nickname" }
  end

  describe '#establised' do
    subject { @team.established }
    it { is_expected.to eq 1900 }
  end

  describe '#motto' do
    subject { @team.motto }
    it { is_expected.to eq "Test Motto" }
  end

  describe '#colour' do
    subject { @team.colour }
    it { is_expected.to eq "#FFFFFF" }
  end

  describe '#dummy' do
    subject { @team.dummy }
    it { is_expected.to eq false }
  end

  describe '#form_matches' do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day1) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 1) }
    let!(:match_day2) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 2) }
    let!(:match_day3) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 3) }
    let!(:match_day4) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 4) }
    let!(:match_day5) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 5) }
    let!(:match_day6) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 6) }
    let!(:match_day7) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 7) }
    let!(:match_day8) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 8) }
    let!(:match1) { FactoryGirl.create(:match, status: :finished, match_day: match_day1, home_team: @team) }
    let!(:match2) { FactoryGirl.create(:match, status: :finished, match_day: match_day2, home_team: @team) }
    let!(:goal1) { FactoryGirl.create(:goal, match: match2, team: match2.home_team) }
    let!(:match3) { FactoryGirl.create(:match, status: :finished, match_day: match_day3, home_team: @team) }
    let!(:match4) { FactoryGirl.create(:match, status: :finished, match_day: match_day4, home_team: @team) }
    let!(:goal2) { FactoryGirl.create(:goal, match: match4, team: match4.away_team) }
    let!(:match5) { FactoryGirl.create(:match, status: :finished, match_day: match_day5, home_team: @team) }
    let!(:match6) { FactoryGirl.create(:match, status: :finished, match_day: match_day6, home_team: @team) }
    let!(:goal3) { FactoryGirl.create(:goal, match: match6, team: match6.home_team) }
    let!(:match7) { FactoryGirl.create(:match, status: :pending, match_day: match_day7, home_team: @team) }
    let!(:match8) { FactoryGirl.create(:match, status: :pending, match_day: match_day7, home_team: @team) }

    before do
      match1.save
      match2.save
      match3.save
      match4.save
      match5.save
      match6.save
      match7.save
      match8.save
    end
    
    specify { expect(@team.form_matches(match_day1)).to eq [match1] }
    specify { expect(@team.form_matches(match_day2)).to eq [match1, match2] }
    specify { expect(@team.form_matches(match_day3)).to eq [match1, match2, match3] }
    specify { expect(@team.form_matches(match_day4)).to eq [match1, match2, match3, match4] }
    specify { expect(@team.form_matches(match_day5)).to eq [match1, match2, match3, match4, match5] }
    specify { expect(@team.form_matches(match_day6)).to eq [match2, match3, match4, match5, match6] }
    specify { expect(@team.form_matches(match_day7)).to eq [match2, match3, match4, match5, match6] }
    specify { expect(@team.form_matches(match_day8)).to eq [match2, match3, match4, match5, match6] }
    specify { expect(@team.form_matches(match_day6, 4)).to eq [match3, match4, match5, match6] }
    specify { expect(@team.form_matches(match_day6, 6)).to eq [match1, match2, match3, match4, match5, match6] }
    specify { expect(match1.result(@team)).to eq :draw }
    specify { expect(match2.result(@team)).to eq :win }
    specify { expect(match3.result(@team)).to eq :draw }
    specify { expect(match4.result(@team)).to eq :loss }
    specify { expect(match5.result(@team)).to eq :draw }
    specify { expect(match6.result(@team)).to eq :win }
    specify { expect(match7.result(@team)).to eq nil }
    specify { expect(match8.result(@team)).to eq nil }
  end
  
  it_should_behave_like "named scope"
  it_should_behave_like "name ordered"
  it_should_behave_like "team players"
  
  context "when nickname is blank" do
    before { @team.nickname = "" }
    it { is_expected.to be_valid }
  end

  context "when stadium is nil" do
    before { @team.stadium = nil }
    it { is_expected.not_to be_valid }
  end

  context "when whoscored_id is nil" do
    before { @team.whoscored_id = nil }
    it { is_expected.not_to be_valid }
  end

  context "when name is blank" do
    before { @team.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "when code is blank" do
    before { @team.code = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when established is nil" do
    before { @team.established = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when motto is nil" do
    before { @team.whoscored_id = nil }
    it { is_expected.not_to be_valid }
  end

  context "when colour is nil" do
    before { @team.colour = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when colour is invalid" do
    before { @team.colour = "123123" }
    it { is_expected.not_to be_valid }
  end

  context "when dummy is nil" do
    before { @team.dummy = nil }
    it { is_expected.not_to be_valid }
  end
    
  context "with home_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:match, home_team: owner) }      
    end
  end

  context "with away_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:match, away_team: owner) }      
    end
  end

  context "with player_match_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:player_match_stat, team: owner) }      
    end
  end
  
  context "with goal dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:goal, team: owner) }      
    end
  end

  context "with card dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:card, team: owner) }      
    end
  end

  context "with substitution dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:substitution, team: owner) }      
    end
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, team: owner) }      
    end
  end

  context "with transfer_listing dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:transfer_listing, team: owner) }      
    end
  end

  context "with team_table_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:team_table_stat, team: owner) }      
    end
  end

  context "with team_registration dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:team_registration, team: owner) }      
    end
  end

  context "with team_match_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:team_match_squad_stat, team: owner) }      
    end
  end

  context "with team_season_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:team) }
      let!(:dependent) { FactoryGirl.create(:team_season_squad_stat, team: owner) }      
    end
  end
  
end
