module UPS
  module RequestXML

    class ShipFromNode < Base


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
        
          xml.ShipFrom {
            xml.CompanyName @company_name
            xml.AttentionName @attention_name          unless @attention_name.nil?
            xml.TaxIdentificationNumber @tax_id_number unless @tax_id_number.nil?
            xml.PhoneNumber @phone_number              unless @phone_number.nil?
            xml.FaxNumber @fax_number                  unless @fax_number.nil?
            xml.EMailAddress @email_address            unless @email_address.nil?
            xml << AddressNode.new(@address).to_xml    
          }

        end
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
