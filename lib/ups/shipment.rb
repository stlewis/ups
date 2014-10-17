module UPS

  class Shipment < Request

    attr_reader :label_image, :html_image, :response_xml, :response

    def initialize(credentials, packages = [], options = {}, api_options = {})
      super(credentials, api_options)
      @options               = options
      @packages              = packages
    end

    def add_package(package_data)
      @packages << package_data 
    end

    def shipper=(shipper_data)
      @options[:shipper] = shipper_data
    end

    def ship_to=(ship_to_data)
      @options[:ship_to] = ship_to_data
    end

    def service=(service_code)
      @options[:service] = {code: service_code}
    end

    def payment_info=(payment_data)
      @options[:payment_info] = payment_data
    end

    def shipment_info=(shipment_info)
      @options[:shipment] = shipment_info
    end

    def label_specification=(label_info)
      @options[:label_specification] = label_info
    end

    def validate_delivery_address=(should_validate)
      @options[:request] ||= {request_action: 'ShipConfirm'}
      @options[:request][:request_option] = should_validate ? 'validate' : 'nonvalidate'
    end

    def create
      @access_request_node           = UPS::RequestXML::AccessRequestNode.new(@credentials)
      @shipment_confirm_request_node = UPS::RequestXML::ShipmentConfirmRequestNode.new(@packages, @options)
      
      raw_response  = send_request(api_url + '/ShipConfirm', @shipment_confirm_request_node)
      @response      = ConfirmResponse.new(raw_response)

      if @response.successful?
        @shipment_accept_request_node = RequestXML::ShipmentAcceptRequestNode.new(response.digest)
        raw_response = send_request(api_url + '/ShipAccept', @shipment_accept_request_node)
        @response     = AcceptResponse.new(raw_response)
        
        if @response.successful?
         @label_image = response.label_image
         @html_image  = response.html_image
         return true
        end
      else
        raise @response.raw_response
        # FIXME Handle errors
      end
    end
  
  end

end
