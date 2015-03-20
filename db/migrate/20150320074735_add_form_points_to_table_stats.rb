class AddFormPointsToTableStats < ActiveRecord::Migration
  def change
    add_column :team_table_stats, :form_points, :integer
    add_column :d11_team_table_stats, :form_points, :integer
  end
end
