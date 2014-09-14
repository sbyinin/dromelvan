premier_leagues = [
  [ "Barclaycard Premier League", "2001-2002" ],
  [ "Barclaycard Premier League", "2002-2003" ],
  [ "Barclaycard Premier League", "2003-2004" ],
  [ "Barclaycard Premier League", "2004-2005" ],
  [ "Barclays Premier League", "2008-2009" ],
  [ "Barclays Premier League", "2009-2010" ],
  [ "Barclays Premier League", "2010-2011" ],
  [ "Barclays Premier League", "2011-2012" ],
  [ "Barclays Premier League", "2012-2013" ],
  [ "Barclays Premier League", "2013-2014" ]           
]

puts("Seeding premier_leagues...")

premier_leagues.each do |name, season|
  PremierLeague.create(name: name, season: Season.where(name: season).first)
end
