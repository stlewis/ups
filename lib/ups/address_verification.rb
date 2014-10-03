module UPS
  class AddressVerification < Request

    def initialize(credentials, address = {})
      @credentials = credentials
      @address     = address
      
    end

    def verify
      @access_request_node       = UPS::RequestXML::AccessRequestNode.new(@credentials)
      @address_validation_node   = UPS::RequestXML::AddressValidationRequestNode.new(@address)
      
      raw_response               = send_request(API_URL + '/XAV', @address_validation_node)
      @response                  = AddressValidationResponse.new(raw_response)
      p @response.raw_response
      return @response.valid_address? if @response.successful?
      raise @response.raw_response 
    end

  end
end
