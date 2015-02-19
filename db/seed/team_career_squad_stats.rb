puts("Seeding team career squad stats...")

Team.all.each do |team|
  TeamCareerSquadStat.create(team: team)
end
