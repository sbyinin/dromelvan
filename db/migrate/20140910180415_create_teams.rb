class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :code
      t.string :nickname
      t.integer :established
      t.string :motto
      t.integer :stadium_id
      t.integer :whoscored_id
      t.attachment :club_crest

      t.timestamps
    end
  end
end
