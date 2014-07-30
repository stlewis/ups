module UPS
  module RequestXML

    class AddressNode < Base
      attr_reader :address_line1, :address_line2, :address_line3, :city, :state, :postal_code, :country_code, :is_residential

      def to_xml(root_node)
      
        request = Nokogiri::XML::Builder.new do |xml|
          xml.send(root_node) {
            xml.AddressLine1 @address_line1 unless @address_line1.nil?
            xml.AddressLine2 @address_line2 unless @address_line2.nil?
            xml.AddressLine3 @address_line3 unless @address_line3.nil?
            xml.City @city                  unless @city.nil?
            xml.StateProvinceCode @state    unless @state.nil?
            xml.PostalCode @postal_code     unless @postal_code.nil?
            xml.CountryCode @country_code
            xml.ResidentialAddress          unless @is_residential.nil?
          }

        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
