module UPS
  module RequestXML

    class TransactionReferenceNode < Base

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.TransactionReference{
            xml.CustomerContext @customer_context
          }
        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
