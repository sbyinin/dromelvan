class AddColourToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :colour, :string
  end
end
