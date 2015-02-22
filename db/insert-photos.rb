# Run this with: rails runner "eval(File.read 'db/insert-photos.rb')"

Dir.entries("project/graphics/player-photos").each do |file_name|
  name = file_name.sub('.jpg','').parameterize
  player = Player.where(parameterized_name: name).first
  if !player.nil?
    puts(player.name)
    player.player_photo = File.new("project/graphics/player-photos/#{file_name}")
    player.save
    File.rename "project/graphics/player-photos/#{file_name}", "project/graphics/player-photos/inserted/#{file_name}"
  else
    players = Player.named(name)
    if players.size == 1
      player = players.first
      player.player_photo = File.new("project/graphics/player-photos/#{file_name}")
      player.save      
      puts(player.name)
      File.rename "project/graphics/player-photos/#{file_name}", "project/graphics/player-photos/inserted/#{file_name}"      
    end
  end
  
end
