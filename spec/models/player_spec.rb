require 'rails_helper'

describe Player, type: :model do

  let(:country) { FactoryGirl.create(:country) }
  
  before { @player = FactoryGirl.create(:player, first_name: "First",
                                                 last_name: "Last",
                                                 full_name: "Full Name",
                                                 country: country,
                                                 date_of_birth: Date.today - 30.year - 1.day,
                                                 height: 180,
                                                 weight: 80) }

  subject { @player }
  
  it { is_expected.to respond_to(:country) }
  it { is_expected.to respond_to(:whoscored_id) }
  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:full_name) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:reversed_name) }  
  it { is_expected.to respond_to(:short_name) }
  it { is_expected.to respond_to(:parameterized_name) }
  it { is_expected.to respond_to(:date_of_birth) }
  it { is_expected.to respond_to(:age) }
  it { is_expected.to respond_to(:height) }
  it { is_expected.to respond_to(:weight) }
  it { is_expected.to respond_to(:player_photo) }
  it { is_expected.to respond_to(:season_info) }

  it { is_expected.to be_valid }
  
  describe '#country' do
    subject { @player.country }
    it { is_expected.to eq country }
  end

  describe '#name' do
    subject { @player.name }
    it { is_expected.to eq "#{@player.first_name} #{@player.last_name}".strip }
  end

  describe '#reversed_name' do
    subject { @player.reversed_name }
    it { is_expected.to eq "#{@player.last_name} #{@player.first_name}".strip }
  end

  describe '#short_name' do
    subject { @player.short_name }
    it { is_expected.to eq "#{@player.last_name} #{@player.first_name[0]}".strip }
  end

  describe '#parameterized_name' do
    subject { @player.parameterized_name }
    it { is_expected.to eq @player.name.parameterize }
  end

  describe '#season_info' do
    # Check that this method returns an object even if there isn't one in the database.
    let(:season) { FactoryGirl.create(:season) }
    let(:player_season_info) { @player.season_info(season) }
    
    specify { expect(player_season_info).not_to be_nil }
    specify { expect(player_season_info.player).to eq @player }
    specify { expect(player_season_info.season).to eq season }
  end

  describe '#age' do
    subject { @player.age }
    it { is_expected.to eq 30 }
  end
        
  context "when full_name is blank" do
    before { @player.full_name = "" }
    it { is_expected.to be_valid }
  end
  
  context "when first_name is nil" do
    before { @player.first_name = nil }
    it { is_expected.not_to be_valid }
  end
  
  context "when last_name is nil" do
    before { @player.last_name = nil }
    it { is_expected.not_to be_valid }
  end

  context "when last_name is blank" do
    before { @player.last_name = "" }
    it { is_expected.not_to be_valid }
  end
  
  context "when country is nil" do
    before { @player.country = nil }
    it { is_expected.not_to be_valid }
  end

  context "when height is invalid" do
    before { @player.height = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when weight is invalid" do
    before { @player.weight = -1 }
    it { is_expected.not_to be_valid }
  end

  context "when whoscored_id is invalid" do
    before { @player.whoscored_id = -1 }
    it { is_expected.not_to be_valid }
  end

  context "with player_match_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:player_match_stat, player: owner) }      
    end
  end
  
  context "with goal dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:goal, player: owner) }      
    end
  end

  context "with card dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:card, player: owner) }      
    end
  end

  context "with substitution dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:substitution, player: owner) }      
    end
  end

  context "with in_substitution dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:substitution, player_in: owner) }      
    end
  end

  context "with player_season_info dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:player_season_info, player: owner) }      
    end
  end

  context "with player_season_stat dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:player_season_stat, player: owner) }      
    end
  end

  context "with transfer_listing dependents" do    
    it_should_behave_like "all dependency owners" do
      let!(:owner) { FactoryGirl.create(:player) }
      let!(:dependent) { FactoryGirl.create(:transfer_listing, player: owner) }      
    end
  end

  describe "default scope order" do
    before { Player.destroy_all }
    
    let!(:player1) { FactoryGirl.create(:player, first_name: "C", last_name: "A") }
    let!(:player2) { FactoryGirl.create(:player, first_name: "A", last_name: "A") }
    let!(:player3) { FactoryGirl.create(:player, first_name: "A", last_name: "B") }    
    
    specify { expect(Player.all).to eq [ player2, player1, player3 ] }
  end
  
  # Can't used the shared examples for named here since Player does not have a real name property,
  # only one from the combination of first_name and last_name.
  describe "named scope" do
    
    before { Player.destroy_all }
  
    let!(:player1) { FactoryGirl.create(:player, first_name: "FirstB", last_name: "LastB") }
    let!(:player2) { FactoryGirl.create(:player, first_name: "FirstA", last_name: "LastA") }
    
    context "with valid search term" do
      let(:found_players) { Player.named(player1.name) }
      
      specify { expect(found_players).to eq [ player1 ] }      
    end
  
    context "with partially valid search terms" do
      let(:found_players) { Player.named("#{player1.name[0,3]} #{player1.name[-3,3]}") }
  
      specify { expect(found_players).to eq [ player1 ] }            
    end
  
    context "with multiple matches" do
      let(:found_players) { Player.named("#{player1.name[0,3]}") }
      
      specify { expect(found_players).to eq [ player2, player1] }      
    end
  
    context "with invalid search term" do
      let(:found_players) { Player.named("#{player1.name} foo") }
      
      specify { expect(found_players).to be_empty }      
    end
    
    context "with empty search term" do
      let(:found_players) { Player.named("") }
      
      specify { expect(found_players).to be_empty }
    end
    
    context "with exact search term" do
      let!(:player3) { FactoryGirl.create(:player, first_name: "", last_name: "LastA") }
      let(:found_players) { Player.named("\"LastA\"") }
      
      specify { expect(found_players).to eq [ player3 ] }
    end
    
    context "with non-english characters" do
      let!(:player3) { FactoryGirl.create(:player, first_name: "Åäöüúïíéèáóñ") }
      let(:found_players) { Player.named("Aaouuiieeaon") }
      
      specify { expect(found_players).to eq [ player3 ] }      
    end
    
  end
  
end
