module UPS
  module RequestXML

    class PackageServiceOptionsNode < Base
      attr_reader :delivery_confirmation, :insured_value


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.PackageServiceOptions {
            xml << DeliveryConfirmationNode.new(@delivery_confirmation).to_xml if @delivery_confirmation
            xml << InsuredValueNode.new(@insured_value).to_xml if @insured_value
          }
        end

        Nokogiri::XML(request.to_xml).root.to_xml 
      end

    end
  
  end
end
