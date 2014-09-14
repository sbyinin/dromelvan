class CreateD11Leagues < ActiveRecord::Migration
  def change
    create_table :d11_leagues do |t|
      t.integer :season_id
      t.string :name

      t.timestamps
    end
  end
end
