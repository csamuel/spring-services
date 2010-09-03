module SpringServices
  require 'spring-services/railtie' if defined?(Rails)
end

class ActionController::Base
  
  def bean(bean_name)
    $SPRING_CONTEXT.getBean(bean_name.to_s)
  end
  
  def self.include_spring_bean(*bean_names)
    raise "Initialization error: you must specify one bean at least" unless bean_names || bean_names.to_a.empty?
    
    bean_names.to_a.each do |bean_name|
      define_method bean_name do
        var_name = :"@#{bean_name}"
        instance_variable_defined?(var_name) ? instance_variable_get(var_name) :
          instance_variable_set(var_name, self.bean(bean_name))
      end
    end
  end
end



