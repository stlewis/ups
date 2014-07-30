module UPS
  module RequestXML

    class PackagingDimensionsNode < Base

      UNITS_OF_MEASURE = {
        "IN" => "Inches",
        "CM" => "Centimeters",
        "00" => "Metric Units Of Measurement",
        "01" => "English Units of Measurement"
      }
      
      attr_reader :length, :width, :height, :code

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.Dimensions{
            xml.Length @length
            xml.Width @width
            xml.Height @height
            xml.UnitOfMeasurement{
              xml.Code @code
              xml.Description UNITS_OF_MEASURE[@code]
            }
          }
        end
        
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
