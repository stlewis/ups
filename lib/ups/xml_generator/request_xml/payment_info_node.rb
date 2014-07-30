module UPS
  module RequestXML

    class PaymentInfoNode < Base
      attr_reader :prepaid_info, :bill_3rd_party_info, :freight_collect_info, :consignee_billed


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
        
          xml.PaymentInformation {
            xml << PrepaidInfoNode.new(@prepaid_info).to_xml                if @prepaid_info
            xml << Bill3rdPartyInfoNode.new(@bill_3rd_party_info).to_xml    if @bill_3rd_party_info
            xml << FreightCollectInfoNode.new(@freight_collect_info).to_xml if @freight_collect_info
            xml.ConsigneeBilled if @consignee_billed
          }

        end
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
