module UPS

  class ConfirmResponse
    attr_reader :raw_response, :xml

    def initialize(raw_response)
      @raw_response = raw_response  
      @xml          = Nokogiri::XML(@raw_response)
    end

    def tracking_number
     @xml.at('/ShipmentConfirmResponse/ShipmentIdentificationNumber').content
    end

    def digest
      @xml.at('/ShipmentConfirmResponse/ShipmentDigest').content
    end

    def total_cost
      @xml.at('/ShipmentConfirmResponse/ShipmentCharges/TotalCharges/MonetaryValue').content
    end

    def error_message
      @xml.at('/ShipmentConfirmResponse/Response/Error/ErrorDescription').content
    end

    def successful?
      @xml.at('/ShipmentConfirmResponse/Response/ResponseStatusCode').content == '1'
    end
  end

end
