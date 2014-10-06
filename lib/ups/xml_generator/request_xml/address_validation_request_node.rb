module UPS
  module RequestXML

    class AddressValidationRequestNode < Base
      attr_reader :address_line1, :suite, :city, :state, :zip, :country

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.AddressValidationRequest{
            xml.Request{
              xml.RequestAction 'XAV'
              xml.RequestOption '3' # 1 for Address Validation.  Can also do Classification (2) or both, (3)
            }
            xml.MaximumListSize 15 # We don't want any correction options returned.
            
            xml.AddressKeyFormat{
              xml.AddressLine  @address_line1
              xml.AddressLine  @suite
              xml.PoliticalDivision2 @city
              xml.PoliticalDivision1 @state
              xml.PostcodePrimaryLow @zip
              xml.CountryCode @country
            }
              
          }

        end

        Nokogiri::XML(request.to_xml).to_xml
      end

    end
  
  end
end
