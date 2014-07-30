module UPS
  module RequestXML

    class LabelSpecificationNode < Base
      PRINT_METHOD_CODES = ['GIF', 'EPL', 'ZPL', 'STARPL', 'SPL']

      attr_reader :code
         


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.LabelSpecification{
            xml.HTTPUserAgent @user_agent ? @user_agent : 'Mozilla/4.5'
            xml.LabelStockSize{
              xml.Height 4 # Only valid value
              xml.Width @label_width # Can be 6 or 8
            }
            xml.LabelImageFormat{
              xml.Code 'GIF'  # Seems like this is the only supported value for remote server -- could also be PNG?
            }
            xml.LabelPrintMethod{
              xml.Code @code
            }
          }
        end
        
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end

# FIXME ReceiptSpecification
# FIXME Instruction
