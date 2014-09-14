module SeasonUniqueName
  extend ActiveSupport::Concern

  included do
    scope :unique_name_ordered, -> { joins(:season).order('seasons.date DESC') }
    
    def unique_name
      season.name
    end          
  end
    
end