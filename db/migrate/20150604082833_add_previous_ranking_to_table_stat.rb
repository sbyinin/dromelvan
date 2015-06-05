class AddPreviousRankingToTableStat < ActiveRecord::Migration
  def change
    add_column :team_table_stats, :previous_ranking, :integer
    add_column :d11_team_table_stats, :previous_ranking, :integer
  end
end
