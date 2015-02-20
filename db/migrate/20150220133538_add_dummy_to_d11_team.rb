class AddDummyToD11Team < ActiveRecord::Migration
  def change
    add_column :d11_teams, :dummy, :boolean
  end
end
