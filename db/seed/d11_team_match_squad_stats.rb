puts("Seeding d11_team_match_squad_stats...")

D11Match.all.each do |d11_match|
  D11TeamMatchSquadStat.create(d11_team: d11_match.home_d11_team, d11_match: d11_match)
  D11TeamMatchSquadStat.create(d11_team: d11_match.away_d11_team, d11_match: d11_match)  
end
