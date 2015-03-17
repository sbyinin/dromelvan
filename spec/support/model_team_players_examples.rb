shared_examples_for "team players" do
  
  it { is_expected.to respond_to(:most_valuable_player) }
  it { is_expected.to respond_to(:top_scorer) }
  
  describe "#most_valuable_player and #top_scorer" do
    let!(:season) { FactoryGirl.create(:season) }
    let!(:premier_league) { FactoryGirl.create(:premier_league, season: season) }
    let!(:match_day) { FactoryGirl.create(:match_day, premier_league: premier_league) }
    let!(:match) { FactoryGirl.create(:match, match_day: match_day) }    
    let!(:player_match_stat1) { FactoryGirl.create(:player_match_stat, match: match, goals: 1) }
    let!(:player_match_stat2) { FactoryGirl.create(:player_match_stat, match: match, goals: 2) }
    let!(:player_match_stat3) { FactoryGirl.create(:player_match_stat, match: match, goals: 3) }    
    let!(:player_season_stat1) { FactoryGirl.create(:player_season_stat, player: player_match_stat1.player, season: season, ranking: 2)}
    let!(:player_season_stat2) { FactoryGirl.create(:player_season_stat, player: player_match_stat2.player, season: season, ranking: 3)}
    let!(:player_season_stat3) { FactoryGirl.create(:player_season_stat, player: player_match_stat3.player, season: season, ranking: 1)}
    
    let!(:player_season_info1) { FactoryGirl.create(:player_season_info, season: season, player: player_season_stat1.player, subject.class.name.underscore.to_sym => subject)}
    let!(:player_season_info2) { FactoryGirl.create(:player_season_info, season: season, player: player_season_stat2.player, subject.class.name.underscore.to_sym => subject)}
    let!(:player_season_info3) { FactoryGirl.create(:player_season_info, season: season, player: player_season_stat3.player)}
    
    specify { expect(subject.most_valuable_player(season)).to eq player_season_stat1 }
    specify { expect(subject.top_scorer(season)).to eq player_season_stat2 } 
  end
  
end
