module UPS
  module RequestXML

    class ShipmentConfirmRequestNode < Base
      attr_reader :shipper, :ship_to, :service, :payment_info, :request, :ship_from, :label_specification, :return_service

      def initialize(packages, options = {})
        super(options)
        shipment_nodes = []
        shipment_nodes << RequestXML::ShipperNode.new(@shipper)                        
        shipment_nodes << RequestXML::ConsigneeNode.new(@ship_to)                      
        shipment_nodes << RequestXML::ServiceNode.new(@service)                        
        shipment_nodes << RequestXML::ShipFromNode.new(@ship_from) if @ship_from
        shipment_nodes << RequestXML::PaymentInfoNode.new(@payment_info)              
        shipment_nodes << RequestXML::ReturnServiceNode.new(@return_service) if @return_service
        # FIXME Alternate Delivery Address
        # FIXME Sold To
       
        packages.each do |package|
          shipment_nodes << RequestXML::PackageNode.new(package)
        end                                                           # description, documents_only
        shipment_options = options[:shipment] || {}
        shipment_node    = RequestXML::ShipmentNode.new(shipment_nodes, shipment_options) 
        
        @scr_nodes    = []
        @scr_nodes    << shipment_node
        @scr_nodes    << RequestXML::LabelSpecificationNode.new(@label_specification)
        @scr_nodes    << RequestXML::RequestNode.new(@request)
      end

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          
          xml.ShipmentConfirmRequest{
            @scr_nodes.each do |node|
              xml << node.to_xml
            end
          }


        end
        request.to_xml
        
      end


    end
  end
end
