# This is tested in spec/models/match_spec.rb
module Postponed

  def postpone
    change(year: 3000, month: 1, day: 1)
  end
  
  def postponed?
    self.year >= 3000
  end
    
  Date.send(:include, Postponed)
  
end