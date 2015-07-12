require 'rails_helper'

describe D11Team, type: :model do
  # This has to be 'team_owner' since 'owner' is used by the shared dependency owner examples
  let(:team_owner) { FactoryGirl.create(:user) }
  let(:co_owner) { FactoryGirl.create(:user) }
  
  before { @d11_team = FactoryGirl.create(:d11_team, owner: team_owner, co_owner: co_owner, name: "Test D11 Team", code: "TDT") }
  
  subject { @d11_team }

  it { is_expected.to respond_to(:owner) }
  it { is_expected.to respond_to(:co_owner) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:dummy) }
  it { is_expected.to respond_to(:club_crest) }

  it { is_expected.to be_valid }

  describe '#owner' do
    subject { @d11_team.owner }
    it { is_expected.to eq team_owner }
  end

  describe '#co_owner' do
    subject { @d11_team.co_owner }
    it { is_expected.to eq co_owner }
  end

  describe '#name' do
    subject { @d11_team.name }
    it { is_expected.to eq "Test D11 Team" }
  end

  describe '#code' do
    subject { @d11_team.code }
    it { is_expected.to eq "TDT" }
  end
  
  describe '#dummy' do
    subject { @d11_team.dummy }
    it { is_expected.to eq false }
  end

  describe '#form_matches' do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
    let!(:d11_match_day1) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 1) }
    let!(:d11_match_day2) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 2) }
    let!(:d11_match_day3) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 3) }
    let!(:d11_match_day4) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 4) }
    let!(:d11_match_day5) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 5) }
    let!(:d11_match_day6) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 6) }
    let!(:d11_match_day7) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 7) }
    let!(:d11_match_day8) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 8) }
    let!(:d11_match1) { FactoryGirl.create(:d11_match, status: :finished, d11_match_day: d11_match_day1, home_d11_team: @d11_team) }
    let!(:d11_match2) { FactoryGirl.create(:d11_match, status: :finished, d11_match_day: d11_match_day2, home_d11_team: @d11_team, home_team_points: 1) }
    let!(:d11_match3) { FactoryGirl.create(:d11_match, status: :finished, d11_match_day: d11_match_day3, home_d11_team: @d11_team) }
    let!(:d11_match4) { FactoryGirl.create(:d11_match, status: :finished, d11_match_day: d11_match_day4, home_d11_team: @d11_team, away_team_points: 1) }
    let!(:d11_match5) { FactoryGirl.create(:d11_match, status: :finished, d11_match_day: d11_match_day5, home_d11_team: @d11_team) }
    let!(:d11_match6) { FactoryGirl.create(:d11_match, status: :finished, d11_match_day: d11_match_day6, home_d11_team: @d11_team, home_team_points: 1) }
    let!(:d11_match7) { FactoryGirl.create(:d11_match, status: :pending, d11_match_day: d11_match_day7, home_d11_team: @d11_team) }
    let!(:d11_match8) { FactoryGirl.create(:d11_match, status: :pending, d11_match_day: d11_match_day7, home_d11_team: @d11_team) }

    specify { expect(@d11_team.form_matches(d11_match_day1)).to eq [d11_match1] }
    specify { expect(@d11_team.form_matches(d11_match_day2)).to eq [d11_match1, d11_match2] }
    specify { expect(@d11_team.form_matches(d11_match_day3)).to eq [d11_match1, d11_match2, d11_match3] }
    specify { expect(@d11_team.form_matches(d11_match_day4)).to eq [d11_match1, d11_match2, d11_match3, d11_match4] }
    specify { expect(@d11_team.form_matches(d11_match_day5)).to eq [d11_match1, d11_match2, d11_match3, d11_match4, d11_match5] }
    specify { expect(@d11_team.form_matches(d11_match_day6)).to eq [d11_match2, d11_match3, d11_match4, d11_match5, d11_match6] }
    specify { expect(@d11_team.form_matches(d11_match_day7)).to eq [d11_match2, d11_match3, d11_match4, d11_match5, d11_match6] }
    specify { expect(@d11_team.form_matches(d11_match_day8)).to eq [d11_match2, d11_match3, d11_match4, d11_match5, d11_match6] }
    specify { expect(@d11_team.form_matches(d11_match_day6, 4)).to eq [d11_match3, d11_match4, d11_match5, d11_match6] }
    specify { expect(@d11_team.form_matches(d11_match_day6, 6)).to eq [d11_match1, d11_match2, d11_match3, d11_match4, d11_match5, d11_match6] }
    specify { expect(d11_match1.result(@d11_team)).to eq :draw }
    specify { expect(d11_match2.result(@d11_team)).to eq :win }
    specify { expect(d11_match3.result(@d11_team)).to eq :draw }
    specify { expect(d11_match4.result(@d11_team)).to eq :loss }
    specify { expect(d11_match5.result(@d11_team)).to eq :draw }
    specify { expect(d11_match6.result(@d11_team)).to eq :win }
    specify { expect(d11_match7.result(@d11_team)).to eq nil }
    specify { expect(d11_match8.result(@d11_team)).to eq nil }
  end
  
  it_should_behave_like "named scope"
  it_should_behave_like "name ordered"
  it_should_behave_like "team players"
  
  context "when co_owner is nil" do
    before { @d11_team.co_owner = nil }
    it { is_expected.to be_valid }
  end

  context "when code is nil" do
    before { @d11_team.code = nil }
    it { is_expected.to be_valid }
  end
  
  context "when owner is nil" do
    before { @d11_team.owner = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when name is blank" do
    before { @d11_team.name = "" }
    it { is_expected.not_to be_valid }
  end

  context "when name is invalid" do
    before { @d11_team.name = "12345678901234567890123456" }
    it { is_expected.not_to be_valid }
  end

  context "when code is invalid" do
    before { @d11_team.code = "1234" }
    it { is_expected.not_to be_valid }
  end

  context "when dummy is nil" do
    before { @d11_team.dummy = nil }
    it { is_expected.not_to be_valid }
  end

  context "with home_d11_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_match, home_d11_team: owner) }      
    end
  end

  context "with away_d11_match dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_match, away_d11_team: owner) }      
    end
  end

  context "with player_match_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:player_match_stat, d11_team: owner) }      
    end
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, d11_team: owner) }      
    end
  end

  context "with transfer_listing dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:transfer_listing, d11_team: owner) }      
    end
  end

  context "with d11_team_table_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_table_stat, d11_team: owner) }      
    end
  end

  context "with d11_team_registration dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_registration, d11_team: owner) }      
    end
  end

  context "with d11_team_match_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_match_squad_stat, d11_team: owner) }      
    end
  end

  context "with d11_team_season_squad_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:d11_team) }
      let!(:dependent) { FactoryGirl.create(:d11_team_season_squad_stat, d11_team: owner) }      
    end
  end
    
end

