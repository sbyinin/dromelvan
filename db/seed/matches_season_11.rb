puts("Fixing season 11")

D11Match.all.each do | d11_match |
  if d11_match.status != 2 then
    d11_match.status = 2
    d11_match.save
  end  
end

puts("Updating d11_team_table_stats...")

d11_match_day = D11League.find(10).d11_match_days.first
d11_match_day.d11_matches.each do |d11_match|
  D11TeamTableStat.update_stats_from(d11_match) 
end
D11TeamTableStat.update_rankings_from(d11_match_day)  

