require 'base64'
module UPS

  class Shipment
    API_URL = 'https://wwwcie.ups.com/ups.app/xml'

    attr_reader :label_image

    def initialize(credentials, packages = [], options = {})
      @credentials           = credentials
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
      
      raw_response  = send_request(API_URL + '/ShipConfirm', @shipment_confirm_request_node)
      response      = ConfirmResponse.new(raw_response)

      if response.successful?
        @shipment_accept_request_node = RequestXML::ShipmentAcceptRequestNode.new(response.digest)
        raw_response = send_request(API_URL + '/ShipAccept', @shipment_accept_request_node)
        response     = AcceptResponse.new(raw_response)
        
        if response.successful?
         @label_image = Base64::decode64(response.label_image)
         return true
        end
      else
        # FIXME Handle errors
      end
    end


    private

      def send_request(url, payload)
        full_request = @access_request_node.to_xml.to_s + payload.to_xml.to_s 
        uri          = URI.parse(url)
        http         = ::Net::HTTP.new(uri.host, 443)
        http.use_ssl = true
        http.post(uri.request_uri, full_request).body
      end
  
  end

end
