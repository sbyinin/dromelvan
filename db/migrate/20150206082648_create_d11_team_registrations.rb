class CreateD11TeamRegistrations < ActiveRecord::Migration
  def change
    create_table :d11_team_registrations do |t|
      t.integer :season_id
      t.integer :d11_team_id
      t.boolean :approved

      t.timestamps
    end
  end
end
