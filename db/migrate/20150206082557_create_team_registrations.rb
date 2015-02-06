class CreateTeamRegistrations < ActiveRecord::Migration
  def change
    create_table :team_registrations do |t|
      t.integer :season_id
      t.integer :team_id

      t.timestamps
    end
  end
end
