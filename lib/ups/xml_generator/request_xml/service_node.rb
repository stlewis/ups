module UPS
  module RequestXML

    class ServiceNode < Base
      attr_reader :code
      SERVICE_CODES = { "01" => "Next Day Air",
                        "02" => "2nd Day Air098 ",
                        "03" => "Ground",
                        "07" => "Express",
                        "08" => "Expedited",
                        "11" => "UPS Standard",
                        "12" => "3 Day Select",
                        "13" => "Next Day Air Save",
                        "14" => "Next Day Air Early AM",
                        "54" => "Express Plus",
                        "59" => "2nd Day Air A.M.",
                        "65" => "UPS Saver",
                        "82" => "UPS Today Standard",
                        "83" => "UPS Today Dedicated Courier",
                        "84" => "UPS Today Intercity",
                        "85" => "UPS Today Express",
                        "86" => "UPS Today Express Saver"}

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          
          xml.Service {
            xml.Code @code
            xml.Description SERVICE_CODES[@code]
          }

        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
