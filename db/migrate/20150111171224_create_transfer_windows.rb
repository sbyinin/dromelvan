class CreateTransferWindows < ActiveRecord::Migration
  def change
    create_table :transfer_windows do |t|
      t.integer :season_id
      t.integer :d11_match_day_id
      t.integer :transfer_window_number
      t.integer :status
      t.datetime :datetime

      t.timestamps
    end
  end
end
