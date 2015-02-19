puts("Seeding player career stats...")

Player.all.each do |player|
  PlayerCareerStat.create(player: player)
end
