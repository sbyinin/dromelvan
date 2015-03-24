class AddStatusToMatchDays < ActiveRecord::Migration
  def change
    add_column :match_days, :status, :integer
  end
end
