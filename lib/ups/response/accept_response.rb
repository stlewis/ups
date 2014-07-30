module UPS

  class AcceptResponse
    attr_reader :raw_response, :xml

    def initialize(raw_response)
      @raw_response = raw_response  
      @xml          = Nokogiri::XML(@raw_response)
    end

    def tracking_number
      @xml.at('/ShipmentAcceptResponse/ShipmentResults/ShipmentIdentificationNumber').content
    end

    def label_image
      @xml.at('/ShipmentAcceptResponse/ShipmentResults/PackageResults/LabelImage/GraphicImage').content
    end

    
    def successful?
      @xml.at('/ShipmentAcceptResponse/Response/ResponseStatusCode').content == '1'
    end
  end

end
