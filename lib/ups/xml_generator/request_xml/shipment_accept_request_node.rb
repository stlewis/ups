module UPS
  module RequestXML

    class ShipmentAcceptRequestNode < Base
      attr_reader :shipment_digest

      def initialize(shipment_digest)
        @shipment_digest = shipment_digest
      end

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.ShipmentAcceptRequest {
            xml.Request {
              xml.RequestAction 'ShipAccept'

            }

            xml.ShipmentDigest @shipment_digest
          }
        end

        request.to_xml
      end


    end
  
  end
end
