module UPS
  module RequestXML

    class ShipperNode < Base
      attr_reader :name, :attention_name, :shipper_number, 
                  :tax_id_number, :phone_number, :fax_number, 
                  :email_address, :address, :company_displyable_name


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
        
          xml.Shipper {
            xml.Name @name
            xml.CompanyDisplayableName @company_displayable_name unless @company_displayable_name.nil?
            xml.AttentionName @attention_name                    unless @attention_name.nil?
            xml.ShipperNumber @shipper_number                    unless @shipper_number.nil?
            xml.TaxIdentificationNumber @tax_id_number           unless @tax_id_number.nil?
            xml.PhoneNumber @phone_number                        unless @phone_number.nil?
            xml.FaxNumber @fax_number                            unless @fax_number.nil?
            xml.EMailAddress @email_address                      unless @email_address.nil?
            
            xml << AddressNode.new(@address).to_xml('Address') unless @address.nil?
          }

        end
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
