module UPS
  module RequestXML

    class PackageNode < Base
      attr_reader :large_package, :additional_handling, :description, :reference_number, :packaging_type, :package_dimensions, :package_weight, :package_service_options


      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          xml.Package {
            xml.LargePackageIndicator if @large_package
            xml.AdditionalHandling if @additional_handling
            xml.Description @description  unless @description.nil?
  
            xml << ReferenceNumberNode.new(@reference_number).to_xml if @reference_number
            xml << PackagingTypeNode.new(@packaging_type).to_xml
            xml << PackagingDimensionsNode.new(@package_dimensions).to_xml if @package_dimensions
            xml << PackageWeightNode.new(@package_weight).to_xml if @package_weight
            xml << PackageServiceOptionsNode.new(@package_service_options).to_xml unless @package_service_options.nil?
          }
        end
        
        Nokogiri::XML(request.to_xml).root.to_xml
      end

    end
  
  end
end
