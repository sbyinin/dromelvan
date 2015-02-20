class AddDummyToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :dummy, :boolean
  end
end
