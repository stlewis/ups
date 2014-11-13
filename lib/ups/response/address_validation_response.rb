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

    def error_message
      @xml.at('/AddressValidationResponse/Response/Error/ErrorDescription')
    end

    def address_suggestions
      suggestions = []
      if !@xml.at('/AddressValidationResponse/NoCandidatesIndicator').nil?
        suggestions << "The Address Matching System is not able to match an address from any USPS database."
      elsif !@xml.at('/AddressValidationResponse/AmbiguousAddressIndicator').nil?
        addresses = @xml.xpath('//AddressKeyFormat')
        addresses.each do |sugg|
          addr = {}
          addr[:address1] = sugg.xpath('AddressLine')[0] ? sugg.xpath('AddressLine')[0].text : ''
          addr[:address2] = sugg.xpath('AddressLine')[1] ? sugg.xpath('AddressLine')[1].text : ''
          addr[:region]   = sugg.xpath('Region') ? sugg.xpath('Region').text : ''
          addr[:city]     = sugg.xpath('PoliticalDivision2') ? sugg.xpath('PoliticalDivision2').text : ''
          addr[:state]    = sugg.xpath('PoliticalDivision1') ? sugg.xpath('PoliticalDivision1').text : ''
          addr[:zip5]     = sugg.xpath('PostcodePrimaryLow') ? sugg.xpath('PostcodePrimaryLow').text : ''
          addr[:zip4]     = sugg.xpath('PostcodeExtendedLow') ? sugg.xpath('PostcodeExtendedLow').text : ''
          addr[:country]  = sugg.xpath('CountryCode') ? sugg.xpath('CountryCode').text : ''
          suggestions << addr
        end
      end
      return suggestions
    end
  end

end