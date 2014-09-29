puts("Seeding player season stats...")

PlayerSeasonInfo.all.each do |player_season_info|
  PlayerSeasonStat.create(player: player_season_info.player, season: player_season_info.season)
end
