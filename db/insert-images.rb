require 'fileutils'
# Run this with: rails runner "eval(File.read 'db/insert-images.rb')"
=begin
Dir.entries("project/graphics/skysports-player-photos").each do |file_name|
  found = false
  name = file_name.sub('.jpg','').parameterize
  player = Player.where(parameterized_name: name).first
  if !player.nil? #&& player.player_photo_file_name.nil?
    found = true
    player.player_photo = File.new("project/graphics/skysports-player-photos/#{file_name}")
    player.save
  else
    players = Player.named(name)
    if players.size == 1
      player = players.first
      #if player.player_photo_file_name.nil?
        found = true
        player.player_photo = File.new("project/graphics/skysports-player-photos/#{file_name}")
        player.save              
      #end
    end
  end
  
  if !found
    puts("Did not find #{file_name}")
  else
    FileUtils.mv("project/graphics/skysports-player-photos/#{file_name}", "project/graphics/moved/#{file_name}")
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
=end

Dir.entries("project/graphics/stadium-photos").each do |file_name|
  name = file_name.sub('.png','')
  stadium = Stadium.where(name: name).first
  if !stadium.nil?
    stadium.photo = File.new("project/graphics/stadium-photos/#{file_name}")
    stadium.save
  else
    puts("Did not find stadium #{name}.")
  end  
end
