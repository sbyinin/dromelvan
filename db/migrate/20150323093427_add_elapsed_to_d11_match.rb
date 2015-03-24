class AddElapsedToD11Match < ActiveRecord::Migration
  def change
    add_column :d11_matches, :elapsed, :string
  end
end
