import org.springframework.web.context.request.SessionScope
import org.springframework.context.support.ClassPathXmlApplicationContext

require 'spring-services'
require 'rails'

module SpringServices
  
  $SPRING_CONTEXT = nil
      
  class Railtie < Rails::Railtie
    initializer "spring_services.configure_rails_initialization" do |app| 
      files = config.spring_context.map { |c| "classpath:#{c}" }.to_java :string
      $SPRING_CONTEXT = ClassPathXmlApplicationContext.new(files)
      $SPRING_CONTEXT.getBeanFactory.registerScope "session", SessionScope.new
    end
  end
end