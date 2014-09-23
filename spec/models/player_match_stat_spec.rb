require 'rails_helper'

describe PlayerMatchStat, type: :model do
  let(:player) { FactoryGirl.create(:player) }
  let(:match) { FactoryGirl.create(:match) }
  let(:team) { FactoryGirl.create(:team) }
  let(:d11_team) { FactoryGirl.create(:d11_team) }
  let(:position) { FactoryGirl.create(:position) }
  let(:played_position) { position.code }

  before { @player_match_stat = FactoryGirl.create(:player_match_stat, player: player, match: match, team: team, d11_team: d11_team, position: position, played_position: played_position) }
  
  subject { @player_match_stat }

  it { is_expected.to respond_to(:player_id) }
  it { is_expected.to respond_to(:match_id) }
  it { is_expected.to respond_to(:team_id) }
  it { is_expected.to respond_to(:d11_team_id) }
  it { is_expected.to respond_to(:position_id) }
  it { is_expected.to respond_to(:played_position) }
  it { is_expected.to respond_to(:lineup) }
  it { is_expected.to respond_to(:substitution_on_time) }
  it { is_expected.to respond_to(:substitution_off_time) }
  it { is_expected.to respond_to(:goals) }
  it { is_expected.to respond_to(:goal_assists) }
  it { is_expected.to respond_to(:own_goals) }
  it { is_expected.to respond_to(:goals_conceded) }
  it { is_expected.to respond_to(:yellow_card_time) }
  it { is_expected.to respond_to(:red_card_time) }
  it { is_expected.to respond_to(:man_of_the_match) }
  it { is_expected.to respond_to(:shared_man_of_the_match) }
  it { is_expected.to respond_to(:rating) }
  it { is_expected.to respond_to(:points) }

  it { is_expected.to be_valid }
  
  describe '#player' do
    subject { @player_match_stat.player }
    it { is_expected.to eq player }
  end

  describe '#match' do
    subject { @player_match_stat.match }
    it { is_expected.to eq match }
  end
  
  describe '#team' do
    subject { @player_match_stat.team }
    it { is_expected.to eq team }
  end
  
  describe '#d11_team' do
    subject { @player_match_stat.d11_team }
    it { is_expected.to eq d11_team }
  end
  
  describe '#position' do
    subject { @player_match_stat.position }
    it { is_expected.to eq position }
  end
  
  describe '#played_position' do
    subject { @player_match_stat.played_position }
    it { is_expected.to eq played_position }
  end
  
  describe '#lineup' do
    subject { @player_match_stat.lineup }
    it { is_expected.to eq 0 }
  end
  
  describe '#substitution_on_time' do
    subject { @player_match_stat.substitution_on_time }
    it { is_expected.to eq 0 }
  end
  
  describe '#substitution_off_time' do
    subject { @player_match_stat.substitution_off_time }
    it { is_expected.to eq 0 }
  end
  
  describe '#goals' do
    subject { @player_match_stat.goals }
    it { is_expected.to eq 0 }
  end
  
  describe '#goal_assists' do
    subject { @player_match_stat.goal_assists }
    it { is_expected.to eq 0 }
  end
  
  describe '#own_goals' do
    subject { @player_match_stat.own_goals }
    it { is_expected.to eq 0 }
  end
  
  describe '#goals_conceded' do
    subject { @player_match_stat.goals_conceded }
    it { is_expected.to eq 0 }
  end
  
  describe '#yellow_card_time' do
    subject { @player_match_stat.yellow_card_time }
    it { is_expected.to eq 0 }
  end
  
  describe '#red_card_time' do
    subject { @player_match_stat.red_card_time }
    it { is_expected.to eq 0 }
  end
  
  describe '#man_of_the_match' do
    subject { @player_match_stat.man_of_the_match }
    it { is_expected.to eq false }
  end

  describe '#shared_man_of_the_match' do
    subject { @player_match_stat.shared_man_of_the_match }
    it { is_expected.to eq false }
  end

  describe '#rating' do
    subject { @player_match_stat.rating }
    it { is_expected.to eq 0 }
  end

  describe '#points' do
    subject { @player_match_stat.points }
    it { is_expected.to eq 0 }
  end

  describe ".by_match_day" do    
    before { PlayerMatchStat.destroy_all }
    
    let!(:match_day) { FactoryGirl.create(:match_day) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
    let!(:player_match_stat) { FactoryGirl.create(:player_match_stat, match: match ) }
    
    specify { expect(PlayerMatchStat.by_match_day(match_day).to_a).to eq [ player_match_stat ] }       
  end
  
  describe ".by_d11_match_day" do
    before { PlayerMatchStat.destroy_all }
    
    let!(:season) { FactoryGirl.create(:season) }
    let!(:d11_league) { FactoryGirl.create(:d11_league, season: season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:d11_match_day) { FactoryGirl.create(:d11_match_day, d11_league: d11_league, match_day_number: 28) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league, match_day_number: 28) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }
    let!(:player_match_stat) { FactoryGirl.create(:player_match_stat, match: match ) }
    
    specify { expect(PlayerMatchStat.by_d11_match_day(d11_match_day).to_a).to eq [ player_match_stat ] }           
  end



  context "when player is nil" do
    before { @player_match_stat.player = nil }
    it { is_expected.not_to be_valid }
  end

  context "when match is nil" do
    before { @player_match_stat.match = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when team is nil" do
    before { @player_match_stat.team = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when d11_team is nil" do
    before { @player_match_stat.d11_team = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when position is nil" do
    before { @player_match_stat.position = nil }
    it { is_expected.not_to be_valid }
  end

  context "when played_position is nil" do
    # This will be updated before_validate
    before { @player_match_stat.played_position = nil }
    it { is_expected.to be_valid }
  end

  context "when played_position is invalid" do
    before { @player_match_stat.played_position = "" }
    it { is_expected.not_to be_valid }
  end

  context "when lineup is nil" do
    before { @player_match_stat.lineup = nil }
    it { is_expected.not_to be_valid }
  end

  context "when lineup is invalid" do
    before { @player_match_stat.lineup = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when substitution_on_time is nil" do
    before { @player_match_stat.substitution_on_time = nil }
    it { is_expected.not_to be_valid }
  end

  context "when substitution_on_time is invalid" do
    before { @player_match_stat.substitution_on_time = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when substitution_off_time is nil" do
    before { @player_match_stat.substitution_off_time = nil }
    it { is_expected.not_to be_valid }
  end

  context "when substitution_off_time is invalid" do
    before { @player_match_stat.substitution_off_time = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when goals is nil" do
    before { @player_match_stat.goals = nil }
    it { is_expected.not_to be_valid }
  end

  context "when goals is invalid" do
    before { @player_match_stat.goals = -1 }
    it { is_expected.not_to be_valid }
  end
  
  context "when goal_assists is nil" do
    before { @player_match_stat.goal_assists = nil }
    it { is_expected.not_to be_valid }
  end

  context "when goal_assists is invalid" do
    before { @player_match_stat.goal_assists = -1 }
    it { is_expected.not_to be_valid }
  end
  
  context "when own_goals is nil" do
    before { @player_match_stat.own_goals = nil }
    it { is_expected.not_to be_valid }
  end

  context "when own_goals is invalid" do
    before { @player_match_stat.own_goals = -1 }
    it { is_expected.not_to be_valid }
  end
  
  context "when goals_conceded is nil" do
    before { @player_match_stat.goals_conceded = nil }
    it { is_expected.not_to be_valid }
  end

  context "when goals_conceded is invalid" do
    before { @player_match_stat.goals_conceded = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when yellow_card_time is nil" do
    before { @player_match_stat.yellow_card_time = nil }
    it { is_expected.not_to be_valid }
  end

  context "when yellow_card_time is invalid" do
    before { @player_match_stat.yellow_card_time = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when red_card_time is nil" do
    before { @player_match_stat.red_card_time = nil }
    it { is_expected.not_to be_valid }
  end

  context "when red_card_time is invalid" do
    before { @player_match_stat.red_card_time = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when man_of_the_match is nil" do
    before { @player_match_stat.man_of_the_match = nil }
    it { is_expected.not_to be_valid }
  end

  context "when shared_man_of_the_match is nil" do
    before { @player_match_stat.shared_man_of_the_match = nil }
    it { is_expected.not_to be_valid }
  end

  context "when rating is nil" do
    before { @player_match_stat.rating = nil }
    it { is_expected.not_to be_valid }
  end

  context "when rating is invalid" do
    before { @player_match_stat.rating = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when points is nil" do
    before { @player_match_stat.points = nil }
    it { is_expected.not_to be_valid }
  end
  

  describe "default scope order" do
    before { PlayerMatchStat.destroy_all }
    
    let(:match1) { FactoryGirl.create(:match, datetime: DateTime.now) }
    let(:match2) { FactoryGirl.create(:match, datetime: DateTime.now - 1.day) }
    let(:player_match_stat1) { FactoryGirl.create(:player_match_stat, match: match1) }
    let(:player_match_stat2) { FactoryGirl.create(:player_match_stat, match: match2) }
   
    specify { expect(PlayerMatchStat.all).to eq [ player_match_stat2, player_match_stat1 ] }
  end
    
end
