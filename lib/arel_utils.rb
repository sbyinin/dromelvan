module ArelUtils
  extend ActiveSupport::Concern
  
  def arel_update_sql
    update_manager = Arel::UpdateManager.new(self.class)
    arel_table = Arel::Table.new(self.class.name.tableize.to_sym)            
    update_manager.table(self.class.name.tableize.to_sym).where(arel_table[:id].eq(self.id))
    update_manager.set( self.arel_update_attributes(arel_table))
    # Need to remove single quotes around table name for this to work in Postgres.
    update_manager.to_sql.gsub "'#{self.class.name.tableize}'", self.class.name.tableize
  end
  
  def arel_update_attributes(arel_table)
    arel_update_attributes = []
    self.updated_at = Time.zone.now
    attributes = self.attributes
    attributes.keys.each do |attribute_key|
      if ![ "id", "created_at" ].include?(attribute_key)
        arel_update_attributes.concat [[arel_table[attribute_key.to_sym], attributes[attribute_key]]]
      end        
    end
    arel_update_attributes
  end
  
  ActiveRecord::Base.send(:include, ArelUtils)
  
end