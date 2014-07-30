module UPS
  module RequestXML

    class ItemizedPaymentInfoNode < Base


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
        
          xml.ItemizedPaymentInformation {
          }

        end
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
