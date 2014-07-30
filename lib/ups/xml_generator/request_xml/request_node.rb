module UPS
  module RequestXML

    class RequestNode < Base
      attr_reader :request_option, :transaction_reference

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.Request{
            xml.RequestAction 'ShipConfirm'
            xml.RequestOption @request_option
            xml << TransactionReference.new(@transaction_reference) if @transaction_reference
           
          }
        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
