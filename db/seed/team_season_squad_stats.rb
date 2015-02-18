puts("Seeding team season squad stats...")

TeamRegistration.all.each do |team_registration|
  TeamSeasonSquadStat.create(team: team_registration.team, season: team_registration.season)
end
