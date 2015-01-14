class AddAndChangeTransferListingColumns < ActiveRecord::Migration
  def change
    rename_column :transfer_listings, :position, :position_id
    add_column :transfer_listings, :d11_team_id, :integer
  end
end
