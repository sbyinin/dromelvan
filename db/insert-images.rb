# Run this with: rails runner "eval(File.read 'db/insert-images.rb')"

Dir.entries("project/graphics/player-photos").each do |file_name|
  found = false
  name = file_name.sub('.jpg','').parameterize
  player = Player.where(parameterized_name: name).first
  if !player.nil? #&& player.player_photo_file_name.nil?
    found = true
    player.player_photo = File.new("project/graphics/player-photos/#{file_name}")
    player.save
  else
    players = Player.named(name)
    if players.size == 1
      player = players.first
      if true # player.player_photo_file_name.nil?
        found = true
        player.player_photo = File.new("project/graphics/player-photos/#{file_name}")
        player.save              
      end
    end
  end
  
  if !found
    puts("Did not find #{file_name}")
  end
end

Dir.entries("project/graphics/club-crests").each do |file_name|
  code = file_name.sub('.png','')
  team = Team.where(code: code).first
  if !team.nil?
    team.club_crest = File.new("project/graphics/club-crests/#{file_name}")
    team.save
  end  
end
