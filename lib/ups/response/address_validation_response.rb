module UPS

  class AddressValidationResponse
    attr_reader :raw_response, :xml

    def initialize(raw_response)
      @raw_response = raw_response  
      @xml          = Nokogiri::XML(@raw_response)
    end

    def successful?
      @xml.at('/AddressValidationResponse/Response/ResponseStatusCode').content.to_i == 1
    end

    def valid_address?
      !@xml.at('/AddressValidationResponse/ValidAddressIndicator').nil?
    end

  end

end
