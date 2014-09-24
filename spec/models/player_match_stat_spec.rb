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

  describe '.update_points' do
    context 'with goals_conceded' do
      let(:defender) { FactoryGirl.create(:position, defender: true) }
      let(:non_defender) { FactoryGirl.create(:position, defender: false) }
      let(:player_match_stat_defender) { FactoryGirl.create(:player_match_stat, lineup: 2, position: defender) }
      let(:player_match_stat_non_defender) { FactoryGirl.create(:player_match_stat, lineup: 2, position: non_defender) }
      let(:player_match_stat_substitute) { FactoryGirl.create(:player_match_stat, lineup: 1, substitution_on_time: 1, position: defender) }
      let(:player_match_stat_unused_substitute) { FactoryGirl.create(:player_match_stat, lineup: 1, substitution_on_time: 0, position: defender) }
      let(:player_match_stat_dnp_non_defender) { FactoryGirl.create(:player_match_stat, lineup: 0, position: non_defender) }
      let(:player_match_stat_dnp_defender) { FactoryGirl.create(:player_match_stat, lineup: 0, position: defender) }
      
      context 'with clean sheet' do
        before do
          player_match_stat_defender.update_points
          player_match_stat_non_defender.update_points
          player_match_stat_substitute.update_points
          player_match_stat_unused_substitute.update_points
          player_match_stat_dnp_non_defender.update_points
          player_match_stat_dnp_defender.update_points
        end
        
        specify { expect(player_match_stat_defender.points).to eq 4 }
        specify { expect(player_match_stat_non_defender.points).to eq 0 }
        specify { expect(player_match_stat_substitute.points).to eq 4 }
        specify { expect(player_match_stat_unused_substitute.points).to eq (-1) }
        specify { expect(player_match_stat_dnp_non_defender.points).to eq 0 }
        specify { expect(player_match_stat_dnp_defender.points).to eq (-1) }
      end
  
      context 'with one goals_conceded' do
        before do
          player_match_stat_defender.goals_conceded = 1
          player_match_stat_non_defender.goals_conceded = 1
          player_match_stat_substitute.goals_conceded = 1
          player_match_stat_unused_substitute.goals_conceded = 1
          player_match_stat_dnp_non_defender.goals_conceded = 1
          player_match_stat_dnp_defender.goals_conceded = 1        
          player_match_stat_defender.update_points
          player_match_stat_non_defender.update_points
          player_match_stat_substitute.update_points
          player_match_stat_unused_substitute.update_points
          player_match_stat_dnp_non_defender.update_points
          player_match_stat_dnp_defender.update_points
        end
        
        specify { expect(player_match_stat_defender.points).to eq 0 }
        specify { expect(player_match_stat_non_defender.points).to eq 0 }
        specify { expect(player_match_stat_substitute.points).to eq 0 }
        specify { expect(player_match_stat_unused_substitute.points).to eq (-1) }
        specify { expect(player_match_stat_dnp_non_defender.points).to eq 0 }
        specify { expect(player_match_stat_dnp_defender.points).to eq (-1) }
      end
      
      context 'with two goals_conceded' do
        before do
          player_match_stat_defender.goals_conceded = 2
          player_match_stat_non_defender.goals_conceded = 2
          player_match_stat_substitute.goals_conceded = 2
          player_match_stat_unused_substitute.goals_conceded = 2
          player_match_stat_dnp_non_defender.goals_conceded = 2
          player_match_stat_dnp_defender.goals_conceded = 2        
          player_match_stat_defender.update_points
          player_match_stat_non_defender.update_points
          player_match_stat_substitute.update_points
          player_match_stat_unused_substitute.update_points
          player_match_stat_dnp_non_defender.update_points
          player_match_stat_dnp_defender.update_points
        end
        
        specify { expect(player_match_stat_defender.points).to eq (-1) }
        specify { expect(player_match_stat_non_defender.points).to eq 0 }
        specify { expect(player_match_stat_substitute.points).to eq (-1) }
        specify { expect(player_match_stat_unused_substitute.points).to eq (-1) }
        specify { expect(player_match_stat_dnp_non_defender.points).to eq 0 }
        specify { expect(player_match_stat_dnp_defender.points).to eq (-1) }
      end
    end 
      
    context 'with yellow_card_time' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, yellow_card_time: 1)}      
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-1) }
    end
    
    context 'with red_card_time' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, red_card_time: 1)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-4) }
    end

    context 'with shared_man_of_the_match' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, shared_man_of_the_match: true)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (2) }
    end
    
    context 'with man_of_the_match' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, man_of_the_match: true)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 4 }
    end

    context 'with goals' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, goals: 1)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 4 }
    end

    context 'with own_goals' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, own_goals: 1)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-4) }
    end
    
    context 'with goal_assists' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, goal_assists: 1)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 2 }
    end
    
    context 'with rating 0.01' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 1)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-6) }
    end
    
    context 'with rating 1' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 100)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-5) }
    end

    context 'with rating 2' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 200)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-4) }
    end
    
    context 'with rating 3' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 300)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-3) }
    end
    
    context 'with rating 4' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 400)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-2) }
    end
    
    context 'with rating 5' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 500)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq (-1) }
    end
    
    context 'with rating 6' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 600)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 0 }
    end
    
    context 'with rating 7' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 700)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 1 }
    end
    
    context 'with rating 8' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 800)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 2 }
    end
    
    context 'with rating 9' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 900)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 3 }
    end
    
    context 'with rating 10' do
      let(:player_match_stat) { FactoryGirl.create(:player_match_stat, lineup: 2, rating: 1000)}
      before { player_match_stat.update_points }
      
      specify { expect(player_match_stat.points).to eq 5 }
    end
    
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
