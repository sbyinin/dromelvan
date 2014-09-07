module HasDependents
  extend ActiveSupport::Concern
  
  def has_dependents?
    self.class.reflect_on_all_associations.collect do | association |
      if association.options[:dependent] == :restrict_with_exception then
        if (association.macro == :has_one && !self.send(association.name).nil?) || 
           (association.macro == :has_many && !self.send(association.name).empty?) then
           return true
        end   
      end
    end
    return false
  end
  
  ActiveRecord::Base.send(:include, HasDependents)
  
end