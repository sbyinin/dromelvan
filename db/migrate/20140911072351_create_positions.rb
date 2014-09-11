class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.string :code
      t.boolean :defender
      t.integer :sort_order

      t.timestamps
    end
  end
end
