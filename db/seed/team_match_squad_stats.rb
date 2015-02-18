puts("Seeding team_match_squad_stats...")

Match.all.each do |match|
  TeamMatchSquadStat.create(team: match.home_team, match: match)
  TeamMatchSquadStat.create(team: match.away_team, match: match)  
end
