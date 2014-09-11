class CreateD11Teams < ActiveRecord::Migration
  def change
    create_table :d11_teams do |t|
      t.integer :owner_id
      t.integer :co_owner_id
      t.string :name
      t.string :code
      t.attachment :club_crest
      
      t.timestamps
    end
  end
end
