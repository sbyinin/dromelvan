teams = [
    [ "None", "???", "", 2001, "", "Unknown", 1, true ],
    [ "Arsenal FC", "ARS", "The Gunners", 1882, "Forward", "Emirates Stadium", 13, false ],
    [ "Aston Villa", "AST", "The Villans", 1874, "Prepared", "Villa Park", 24, false ],    
    [ "Blackburn Rovers", "BLA", "The Rovers", 1875, "Arte Et Labore", "Ewood Park", 158, false ],    
    [ "Bolton Wanderers", "BOL", "The Trotters", 1874, "", "Reebok Stadium", 92, false ],    
    [ "Charlton Athletic", "CHA", "The Addicks", 1905, "", "The Valley", 160, false ],    
    [ "Chelsea FC", "CHE", "The Blues", 1905, "", "Stamford Bridge", 15, false ],    
    [ "Derby County FC", "DER", "The Rams", 1884, "", "Pride Park", 20, false ],    
    [ "Everton FC", "EVE", "The Toffees", 1878, "Nil Satis Nisi Optimum", "Goodison Park", 31, false ],
    [ "Fulham FC", "FUL", "The Cottagers", 1879, "", "Craven Cottage", 170, false ],    
    [ "Ipswich Town", "IPS", "The Tractor Boys", 1878, "", "Portman Road", 165, false ],    
    [ "Leeds United", "LEE", "The Whites", 1919, "", "Elland Road", 19, false ],
    [ "Leicester City", "LEI", "The Foxes", 1884, "", "King Power Stadium", 14, false ],
    [ "Liverpool FC", "LIV", "The Reds", 1882, "You'll Never Walk Alone", "Anfield", 26, false ],    
    [ "Manchester United", "MAU", "The Red Devils", 1878, "", "Old Trafford", 32, false ],
    [ "Middlesbrough FC", "MID", "The Boro", 1876, "", "Riverside Stadium", 21, false ],
    [ "Newcastle United", "NEW", "The Magpies", 1892, "Fortiter Defendit Triumphans", "St. James' Park", 23, false ],
    [ "Southampton FC", "SOU", "The Saints", 1885, "", "St. Mary's Stadium", 18, false ],
    [ "Sunderland AFC", "SUN", "The Black Cats", 1879, "Consectatio Excellentiae", "Stadium of Light", 16, false ],
    [ "Tottenham Hotspur", "TOT", "Spurs", 1882, "Audere est Facere", "White Heart Lane", 30, false ],    
    [ "West Ham United", "WES", "The Irons", 1895, "", "Boleyn Ground", 29, false ],    
    [ "Birmingham City", "BIR", "The Blues", 1875, "", "St Andrew's", 157, false ],    
    [ "West Bromwich Albion", "WBA", "The Baggies", 1878, "Labor omnia vincit", "The Hawthorns", 175, false ],
    [ "Manchester City", "MAC", "The Citizens", 1894, "Superbia in Proelia", "Etihad Stadium", 167, false ],
    [ "Portsmouth FC", "POR", "Pompey", 1898, "Heaven's Light Our Guide", "Fratton Park", 169, false ],
    [ "Wolverhampton Wanderers", "WOL", "Wolves", 1877, "", "Molineux Stadium", 161, false ],
    [ "Norwich City", "NOR", "The Canaries", 1902, "", "Carrow Road", 168, false ],
    [ "Crystal Palace", "CRY", "The Eagles", 1905, "", "Selhurst Park", 162, false ],    
    [ "Deleted Team", "DDD", "", 2001, "", "Unknown", 1, false ],
    [ "Wigan Athletic", "WIG", "The Latics", 1932, "Ancient and Loyal", "DW Stadium", 194, false ],
    [ "Sheffield United", "SHE", "The Blades", 1889, "Deo adjuvante labor proficit", "Bramall Lane", 163, false ],
    [ "Reading FC", "REA", "The Royals", 1871, "A Deo Et Regina", "Madejski Stadium", 94, false ],
    [ "Watford FC", "WAT", "The Hornets", 1881, "", "Vicarage Road", 27, false ],
    [ "Hull City FC", "HUL", "The Tigers", 1904, "", "KC Stadium", 214, false ],
    [ "Stoke City", "STO", "The Potters", 1863, "Vis Unita Fortior", "Britannia Stadium", 96, false ],
    [ "Burnley", "BUR", "The Clarets", 1882, "Pretiumque et Causa Laboris", "Turf Moor", 184, false ],
    [ "Blackpool FC", "BLP", "The Seasiders", 1887, "Progress", "Bloomfield Road", 93, false ],    
    [ "Queens Park Rangers", "QPR", "The Hoops", 1882, "", "Loftus Road", 171, false ],
    [ "Swansea City", "SWA", "The Swans", 1912, "", "Libery Stadium", 259, false ],
    [ "Cardiff City", "CAR", "The Bluebirds", 1899, "Fire and Passion", "Cardiff City Stadium", 188, false ]
]

puts("Seeding teams...")

teams.each do |name, code, nickname, established, motto, stadium, whoscored_id, dummy|
  Team.create(name: name, code: code, nickname: nickname, established: established, motto: motto, stadium: Stadium.where(name: stadium).first, whoscored_id: whoscored_id, dummy: dummy)
end
