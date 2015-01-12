class CreateTransferDays < ActiveRecord::Migration
  def change
    create_table :transfer_days do |t|
      t.integer :transfer_window_id
      t.integer :transfer_day_number
      t.integer :status
      t.datetime :datetime

      t.timestamps
    end
  end
end
