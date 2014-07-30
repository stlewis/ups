module UPS

  module RequestXML
    class Base
      
      def initialize(options = {})
        options.each do |k, v|
          # Any option passed that has a corresponding accessor on this class becomes and instance variable
          self.instance_variable_set("@#{k}", v) if self.respond_to?("#{k}")
        end
      end

      private 
      
      def validate_required(options)
        @required_attributes.flatten.each do |att|
          raise ArgumentError, "Required attribute '#{att}' not set." unless options[att]
        end
      end
        



    end
  end
end
