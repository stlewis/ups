module UPS
  module RequestXML

    class ReturnServiceNode < Base
      RETURN_SERVICE_CODES = {
        '2'  => 'UPS Print and Mail (PNM)',
        '3'  => 'UPS Return Service 1-Attempt(RS1)',
        '5'  => 'UPS Return Service 3-Attempt(RS3)',
        '8'  => 'UPS Electronic Return Label (ERL)',
        '9'  => 'UPS Print Return Label (PRL)',
        '10' => 'UPS Exchange Print Return Label',
        '11' => 'UPS Pack & Collect Service 1-Attempt Box 1:',
        '12' => 'UPS Pack & Collect Service 1-Attempt Box 2:',
        '13' => 'UPS Pack & Collect Service 1-Attempt Box 3:',
        '14' => 'UPS Pack & Collect Service 1-Attempt Box 4:',
        '15' => 'UPS Pack & Collect Service 1-Attempt Box 5:',
        '16' => 'UPS Pack & Collect Service 3-Attempt Box 1:',
        '17' => 'UPS Pack & Collect Service 3-Attempt Box 2:',
        '18' => 'UPS Pack & Collect Service 3-Attempt Box 3:',
        '19' => 'UPS Pack & Collect Service 3-Attempt Box 4:',
        '20' => 'UPS Pack & Collect Service 3-Attempt Box 5:'
      }


      attr_reader :code


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.ReturnService {
            xml.Code @code  
          }
        end
        
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
