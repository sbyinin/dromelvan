puts("Seeding player_match_stats goals conceded...")

count = 0
PlayerMatchStat.all.each do |player_match_stat|
    if player_match_stat.lineup == 2 or player_match_stat.substitution_on_time > 0 then
        match = player_match_stat.match
        team = player_match_stat.team
        goals = match.goals_against(team)
        if goals > 0 then
            player_match_stat.goals_conceded = goals
            player_match_stat.save
        end
    end
    count = count + 1
    #    puts("#{count}")
end
