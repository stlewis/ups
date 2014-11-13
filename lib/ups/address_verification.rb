module UPS
  class AddressVerification < Request

    attr_reader :address_errors, :address_suggestions

    def initialize(credentials, address = {}, api_options = {})
      super(credentials, api_options)
      @address     = address
    end

    def verify
      @access_request_node       = UPS::RequestXML::AccessRequestNode.new(@credentials)
      @address_validation_node   = UPS::RequestXML::AddressValidationRequestNode.new(@address)
      raw_response               = send_request(api_url + '/XAV', @address_validation_node)
      @response                  = AddressValidationResponse.new(raw_response)

      if @response.successful?
        @address_suggestions = @response.address_suggestions
        return @response.valid_address?
      else
        @address_errors = @response.error_message.content if @response.error_message
        raise @response.raw_response if @address_errors.nil?
      end

    end

  end
end
