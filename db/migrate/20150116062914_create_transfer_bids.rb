class CreateTransferBids < ActiveRecord::Migration
  def change
    create_table :transfer_bids do |t|
      t.integer :transfer_day_id
      t.integer :player_id
      t.integer :player_ranking
      t.integer :d11_team_id
      t.integer :d11_team_ranking
      t.integer :fee
      t.integer :active_fee
      t.boolean :successful

      t.timestamps
    end
  end
end
