module UPS
  module RequestXML

    class ConsigneeNode < Base
      attr_reader :company_name, :attention_name, :tax_id_number, :phone_number, :fax_number,
                  :email_address, :location_id, :address



      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          
          xml.ShipTo {
            xml.CompanyName @company_name
            xml.AttentionName @attention_name          unless @attention_name.nil?
            xml.TaxIdentificationNumber @tax_id_number unless @tax_id_number.nil?
            xml.PhoneNumber @phone_number              unless @phone_number.nil?
            xml.FaxNumber @fax_number                  unless @fax_number.nil?
            xml.EMailAddress @email_address            unless @email_address.nil?
            xml.LocationID @location_id                unless @location_id.nil?
            xml << AddressNode.new(@address).to_xml('Address') unless @address.nil? # FIXME This cannot happen
          }

        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
