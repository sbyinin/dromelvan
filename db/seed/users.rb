users = [
  [ "dromelvan@fake.email.com", "Drömelvan", true, "password" ]
]

puts("Seeding users...")

users.each do | email, name, administrator, password |
  User.create(email: email, name: name, administrator: administrator, password: password, password_confirmation: password)
end
