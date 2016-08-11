puts("Updating match goals...")

Match.all.each do |match|
  match.save
end

puts("Seeding player_match_stats goals conceded...")

count = 0
PlayerMatchStat.where(position_id: 1).each do |player_match_stat|
  if player_match_stat.participated? then
    match = player_match_stat.match
    team = player_match_stat.team
    goals = match.goals_against(team)
    if goals > 0 then
       player_match_stat.goals_conceded = goals       
    end
  else
    player_match_stat.goals_conceded = 0
  end  
  player_match_stat.save
  count = count + 1
  puts("GK #{count}")
end

count = 0
PlayerMatchStat.where(position_id: 2).each do |player_match_stat|
  if player_match_stat.participated? then
    match = player_match_stat.match
    team = player_match_stat.team
    goals = match.goals_against(team)
    if goals > 0 then
       player_match_stat.goals_conceded = goals       
    end
  else
    player_match_stat.goals_conceded = 0
  end  
  player_match_stat.save
  count = count + 1
  puts("FB #{count}")
end

count = 0
PlayerMatchStat.where(position_id: 3).each do |player_match_stat|
  if player_match_stat.participated? then
    match = player_match_stat.match
    team = player_match_stat.team
    goals = match.goals_against(team)
    if goals > 0 then
       player_match_stat.goals_conceded = goals       
    end
  else
    player_match_stat.goals_conceded = 0
  end  
  player_match_stat.save
  count = count + 1
  puts("DEF #{count}")
end

puts("Updating player_season_stats...")

PlayerSeasonStat.all.each do |player_season_stat|
  player_season_stat.save
end

Season.all.each do |season|
  puts("  Updating rankings for season #{season.name}...")
  PlayerSeasonStat.update_rankings(season)
end

puts("Updating player career stats...")

PlayerCareerStat.all.each do |player_career_stat|
  player_career_stat.save
end

PlayerCareerStat.update_rankings

puts("Updating d11_team_match_squad_stat")

D11TeamMatchSquadStat.all.each do |d11_team_match_squad_stat|
  d11_team_match_squad_stat.save
end

puts("Updating d11_team_season_squad_stat")

D11TeamSeasonSquadStat.all.each do |d11_team_season_squad_stat|
  d11_team_season_squad_stat.save
end

puts("Updating d11_team_career_squad_stat")

D11TeamCareerSquadStat.all.each do |d11_team_career_squad_stat|
  d11_team_career_squad_stat.save
end

puts("Updating team_match_squad_stat")

TeamMatchSquadStat.all.each do |team_match_squad_stat|
  team_match_squad_stat.save
end

puts("Updating team_season_squad_stat")

TeamSeasonSquadStat.all.each do |team_season_squad_stat|
  team_season_squad_stat.save
end

puts("Updating team_career_squad_stat")

TeamCareerSquadStat.all.each do |team_career_squad_stat|
  team_career_squad_stat.save
end

puts("Updating team_table_stats...")

PremierLeague.all.each do |premier_league|
  match_day = premier_league.match_days.first
  match_day.matches.each do |match|
    TeamTableStat.update_stats_from(match) 
  end
  TeamTableStat.update_rankings_from(match_day)  
end
