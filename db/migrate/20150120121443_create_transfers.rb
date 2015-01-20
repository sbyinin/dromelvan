class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :transfer_day_id
      t.integer :player_id
      t.integer :d11_team_id
      t.integer :fee

      t.timestamps
    end
  end
end
