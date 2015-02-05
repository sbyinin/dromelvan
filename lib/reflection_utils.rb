module ReflectionUtils
  extend ActiveSupport::Concern

  def read_association(name)
    self.class.reflections.keys.each do |key|
      if /#{name}/ =~ key.to_s
        return association(key).association_scope[0]
      end
    end      
  end

  def read_association_class(name)
    self.class.reflections.keys.each do |key|
      if /#{name}/ =~ key.to_s
        return association(key).klass
      end
    end      
  end
  
  ActiveRecord::Base.send(:include, ReflectionUtils)
  
end

