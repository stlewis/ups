module UPS
  module RequestXML
    

    class CreditCardNode < Base
      CREDIT_CARD_TYPES = {
        '01' => "American Express",
        '03' => "Discover",
        '04' => 'MasterCard',
        '05' => 'Optima',
        '06' => 'VISA',
        '07' => 'Bravo',
        '08' => 'Diners Club'
      }
      attr_reader :type, :number, :expiration_date, :security_code, :address


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.CreditCard{
            xml.Type @type
            xml.Number @number
            xml.ExpirationDate @expiration_date
            xml.SecurityCode @security_code
            xml << AddressNode.new(@address).to_xml('Address')
          }
        
        end
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
