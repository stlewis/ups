module UPS
  module RequestXML

    class ShipmentNode < Base
      attr_reader :description, :documents_only

      def initialize(nodes, options = {})
        @nodes = nodes
        super(options)
      end

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          
          xml.Shipment {
            xml.Description @description if @description
            xml.DocumentsOnly if @documents_only
            @nodes.each do |node|
              xml << node.to_xml
            end
          }
        end
        
        return Nokogiri::XML(request.to_xml).root.to_xml
      end
      
    end

  end

end
