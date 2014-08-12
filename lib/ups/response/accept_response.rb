require 'base64'

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

    def html_image
      # We need to interpolate the image into the HTML, otherwise, it's using a relative file source...
      base64  = @xml.at('/ShipmentAcceptResponse/ShipmentResults/PackageResults/LabelImage/HTMLImage').content
      decoded = Base64::decode64(base64)
      html = Nokogiri::HTML(decoded, nil, 'utf-8')
      html.at('//img')['src'] = "data:image/gif;base64,#{label_image}"
      return Base64::encode64(html.to_s)
    end

    
    def successful?
      @xml.at('/ShipmentAcceptResponse/Response/ResponseStatusCode').content == '1'
    end
  end

end
