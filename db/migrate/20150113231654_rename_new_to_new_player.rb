class RenameNewToNewPlayer < ActiveRecord::Migration
  def change
    rename_column :transfer_listings, :new, :new_player
  end
end
