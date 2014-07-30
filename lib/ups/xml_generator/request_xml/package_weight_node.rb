module UPS
  module RequestXML

    class PackageWeightNode < Base

      WEIGHT_UNITS = {
          "LBS" => "Pounds",
          "KGS" => "Kilograms",
          "00" => "Metric Unit of Measurements",
          "01" => "English Unit of Measurements"
        }

      attr_reader :weight, :code

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|

          xml.PackageWeight {
            xml.UnitOfMeasurement {
              xml.Code @code
              xml.Description WEIGHT_UNITS[@code]
            }

            xml.Weight @weight
          }
        end

        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
