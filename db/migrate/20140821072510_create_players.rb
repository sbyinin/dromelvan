class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :country_id
      t.integer :whoscored_id
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.date :date_of_birth
      t.integer :height
      t.integer :weight

      t.timestamps
    end
  end
end
