class CreateStadia < ActiveRecord::Migration
  def change
    create_table :stadia do |t|
      t.string :name
      t.string :city
      t.integer :capacity
      t.integer :opened
      t.attachment :photo
      t.timestamps
    end
  end
end
