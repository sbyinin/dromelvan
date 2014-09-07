class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.integer :status
      t.date :date
      t.boolean :legacy

      t.timestamps
    end
  end
end
