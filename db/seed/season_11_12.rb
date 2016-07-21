seasons = [
  [ "2014-2015", 2, "2014-08-16" ],
  [ "2015-2016", 2, "2015-08-08" ]           
]

puts("Seeding seasons...")

seasons.each do |name, status, date|
  Season.create(name: name, status: status, date: date, legacy: false)
end

d11_leagues = [
  [ "Drömelvan", "2014-2015" ],
  [ "Drömelvan", "2015-2016" ]           
]

puts("Seeding d11_leagues...")

d11_leagues.each do |name, season|
  D11League.create(name: name, season: Season.where(name: season).first)
end

premier_leagues = [
  [ "Barclays Premier League", "2014-2015" ],
  [ "Barclays Premier League", "2015-2016" ]           
]

puts("Seeding premier_leagues...")

premier_leagues.each do |name, season|
  PremierLeague.create(name: name, season: Season.where(name: season).first)
end
