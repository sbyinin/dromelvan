class AddMatchDayIdToD11MatchDay < ActiveRecord::Migration
  def change
    add_column :d11_match_days, :match_day_id, :integer
  end
end
