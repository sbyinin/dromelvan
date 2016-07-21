puts("Updating d11_team_table_stats...")

d11_match_day = D11League.find(5).d11_match_days.where("match_day_number >= 4").first
d11_match_day.d11_matches.each do |d11_match|
  D11TeamTableStat.update_stats_from(d11_match) 
end
D11TeamTableStat.update_rankings_from(d11_match_day)  

