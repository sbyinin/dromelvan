puts("Seeding d11 team career squad stats...")

D11Team.all.each do |d11_team|
  D11TeamCareerSquadStat.create(d11_team: d11_team)
end
