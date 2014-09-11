d11_teams = [
    [ "None", "???" ],
    [ "Andersson", "AND" ],
    [ "Bolin/Gunnarsson", "B/G" ],
    [ "Boman", "BOM" ],
    [ "Egenfelt/Bengtsson", "E/B" ],
    [ "Ekholm", "EKH" ],
    [ "Solax", "SOL" ],
    [ "Eriksson J", "ERJ" ],
    [ "Eriksson M&D", "EMD" ],
    [ "Eriksson/Fonsell", "E/F" ],
    [ "Gröndahl", "GRD" ],
    [ "Jakobsson", "JAK" ],
    [ "Lindroos", "LIN" ],
    [ "Mattsson", "MAT" ],
    [ "Nyman", "NYM" ],
    [ "Sirén", "SIR" ],
    [ "Smeds", "SME" ],
    [ "Sundström", "SUN" ],
    [ "Wahlfors/Wiklund", "W/W" ],
    [ "Viktorssons", "VIK" ],
    [ "Witting", "WIT" ],
    [ "Carlsson/Engblom", "C/E" ],
    [ "Ekholm/Berndtsson", "EKB" ],
    [ "Qvarnström", "QVA" ],
    [ "Rosén/Ekstrand", "R/E" ],
    [ "Carlsson/Brändström", "C/B" ],
    [ "Hjalmarsson", "HJA" ],
    [ "Eriksson M", "ERM" ],
    [ "Grönholm", "GRH" ],      
    [ "Lindholm", "LIH" ],  
    [ "Engblom", "ENG" ],
    [ "Sandberg", "SAN" ],
    [ "Ehres", "EHR" ],
    [ "Östergård", "ÖST" ],
    [ "Egenfelt", "EGE" ],
    [ "Smeds R", "SMR" ],
    [ "Wiklund", "WIK" ],
    [ "Örblom", "ÖRB" ],    
    [ "Egenfelt/Eriksson", "E/E" ],
    [ "Boijer", "BOI" ],
    [ "Möller", "MÖL" ],
    [ "Eriksson D", "ERD" ],
    [ "Holmberg", "HOL" ],
    [ "Karlsson", "KAR" ],        
    [ "Jakobsson J", "JAJ" ],
    [ "Kvarnström", "KVA" ],
    [ "Eriksson/Jansson", "E/J" ],
    [ "Eriksson N", "ERN" ]
]

puts("Seeding d11_teams...")

d11_teams.each do | name, code |
  D11Team.create(name: name, code: code, owner_id: 1)
end
