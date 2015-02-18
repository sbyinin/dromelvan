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
  puts("#{count}")
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
  puts("#{count}")
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
  puts("#{count}")
end

count = 0
PlayerMatchStat.where(position_id: 4).each do |player_match_stat|
  player_match_stat.goals_conceded = 0
  player_match_stat.save
  count = count + 1
  puts("#{count}")
end

count = 0
PlayerMatchStat.where(position_id: 5).each do |player_match_stat|
  player_match_stat.goals_conceded = 0
  player_match_stat.save
  count = count + 1
  puts("#{count}")
end
