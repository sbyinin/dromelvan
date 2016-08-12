module NameScope
  extend ActiveSupport::Concern

  module ClassMethods
    # See first_name_last_name_scope.rb for info about this bit.
    def named(name)
      if !name.blank? then
        name_terms = name.split
        name_count = name_terms.length
        
        where( [(['(lower(name) LIKE lower(?))'] * name_count).join(' AND ')] + name_terms.map { |name_term| "%#{name_term}%" } )
      else
        none
      end      
    end
  end
end