class AddAttachmentPlayerPhotoToPlayers < ActiveRecord::Migration
  def self.up
    change_table :players do |t|
      t.attachment :player_photo
    end
  end

  def self.down
    remove_attachment :players, :player_photo
  end
end
