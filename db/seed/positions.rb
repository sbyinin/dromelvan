positions = [
  [ "Goalkeeper", "GK", true, 1 ],
  [ "Full Back", "FB", true, 2 ],
  [ "Defender", "D", true, 3 ],
  [ "Midfielder", "MF", false, 4 ],
  [ "Forward", "F", false, 5 ],
  [ "Unknown", "?", false, 6 ]
]

puts("Seeding positions...")

positions.each do |name, code, defender, sort_order|
  Position.create(name: name, code: code, defender: defender, sort_order: sort_order)
end
