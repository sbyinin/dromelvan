d11_leagues = [
  [ "Drömelvan", "2001-2002" ],
  [ "Drömelvan", "2002-2003" ],
  [ "Drömelvan", "2003-2004" ],
  [ "Drömelvan", "2004-2005" ],
  [ "Drömelvan", "2008-2009" ],
  [ "Drömelvan", "2009-2010" ],
  [ "Drömelvan", "2010-2011" ],
  [ "Drömelvan", "2011-2012" ],
  [ "Drömelvan", "2012-2013" ],
  [ "Drömelvan", "2013-2014" ]           
]

puts("Seeding d11_leagues...")

d11_leagues.each do |name, season|
  D11League.create(name: name, season: Season.where(name: season).first)
end
