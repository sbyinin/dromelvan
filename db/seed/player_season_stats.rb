puts("Seeding player_season_stats...")

PlayerSeasonInfo.all.each do |player_season_info|
  PlayerSeasonStat.create(player: player_season_info.player, season: player_season_info.season)
end

Season.all.each do |season|
  puts("  Updating rankings for season #{season.name}...")
  PlayerSeasonStat.update_rankings(season)
end
