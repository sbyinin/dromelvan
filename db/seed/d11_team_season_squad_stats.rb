puts("Seeding d11 team season squad stats...")

D11TeamRegistration.all.each do |d11_team_registration|
  D11TeamSeasonSquadStat.create(d11_team: d11_team_registration.d11_team, season: d11_team_registration.season)
end
