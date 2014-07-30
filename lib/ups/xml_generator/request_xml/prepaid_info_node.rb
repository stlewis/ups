module UPS
  module RequestXML

    class PrepaidInfoNode < Base
      attr_reader :account_number, :credit_card_info, :alternate_payment_method


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.Prepaid{
            xml.BillShipper{
              xml.AccountNumber @account_number if @account_number 
              xml << CreditCardNode.new(@credit_card_info).to_xml if @credit_card_info
              xml.AlternatePaymentMethod @alternate_payment_method if @alternate_payment_method
            }
          }
        end
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
