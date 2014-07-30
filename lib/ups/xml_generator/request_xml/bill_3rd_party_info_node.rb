module UPS
  module RequestXML

    class Bill3rdPartyInfoNode < Base
      attr_reader :account_number, :address
                 



      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          
          xml.BillThirdParty {
            xml.BillThirdPartyShipper{
              xml.AccountNumber @account_number if @account_number
              xml.ThirdParty{
                xml << AddressNode.new(@address).to_xml('Address') if @address # NOTE This doesn't take all of the normal fields of an address -- postal code, country code  only
              }
            } 
          }

        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
