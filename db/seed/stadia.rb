stadia = [
  [ "Unknown", "Unknown", 1, 2001 ],
  [ "Anfield", "Liverpool", 45362, 1884 ],
  [ "Boleyn Ground", "London", 35303, 1884 ],    
  [ "Britannia Stadium", "Stoke-on-Trent", 28383, 1997 ],
  [ "Cardiff City Stadium", "Cardiff", 26828, 2009 ],
  [ "Carrow Road", "Norwich", 27033, 1935 ],
  [ "Etihad Stadium", "Manchester", 47726, 2003 ],
  [ "Craven Cottage", "London", 25700, 1896 ],
  [ "Emirates Stadium", "London", 60355, 2006 ],
  [ "Goodison Park", "Liverpool", 40157, 1892 ],
  [ "The Hawthorns", "West Bromwich", 26500, 1900 ],
  [ "KC Stadium", "Kingston upon Hull", 25404, 2002 ],
  [ "Libery Stadium", "Swansea", 20532, 2005 ],
  [ "Old Trafford", "Manchester", 76212, 1910 ],
  [ "St. James' Park", "Newcastle", 52387, 1880 ],
  [ "St. Mary's Stadium", "Southampton", 32689, 2001 ],
  [ "Selhurst Park", "London", 26255, 1924 ],
  [ "Stadium of Light", "Sunderland", 49000, 1997 ],
  [ "Stamford Bridge", "London", 42055, 1877 ],
  [ "Villa Park", "Birmingham", 42788, 1897 ],
  [ "White Heart Lane", "London", 36310, 1899 ],
  [ "Ewood Park", "Blackburn", 31367, 1882 ],
  [ "Reebok Stadium", "Bolton", 28723, 1997 ],
  [ "The Valley", "London", 27111, 1919 ],
  [ "Pride Park", "Derby", 33597, 1997 ],
  [ "Portman Road", "Ipswich", 30311, 1884 ],
  [ "Elland Road", "Leeds", 37914, 1897 ],
  [ "King Power Stadium", "Leicester", 32262, 2002 ],
  [ "Filbert Street", "Leicester", 22000, 1891 ],
  [ "Highbury", "London", 38419, 1913 ],
  [ "Riverside Stadium", "Middlesbrough", 34742, 1995 ],
  [ "St Andrew's", "Birmingham", 30016, 1906 ],
  [ "Fratton Park", "Portsmouth", 20688, 1898 ],
  [ "Molineux Stadium", "Wolverhampton", 30852 ,1889 ],
  [ "DW Stadium", "Wigan", 25138, 1999],
  [ "Bramall Lane", "Sheffield", 32702, 1855 ],
  [ "Madejski Stadium", "Reading", 24161, 1998 ],
  [ "Vicarage Road", "Watford", 17477, 1922 ],
  [ "Turf Moor", "Burnley", 22546, 1883],
  [ "Bloomfield Road", "Blackpool", 17338, 1899 ],
  [ "Loftus Road", "London", 18489, 1904 ]
]

puts("Seeding stadia...")

stadia.each do |name, city, capacity, opened|
  Stadium.create(name: name, city: city, capacity: capacity, opened: opened)
end
