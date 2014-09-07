class AddParameterizedNameToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :parameterized_name, :string
  end
end
