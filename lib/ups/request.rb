module UPS
  class Request
    API_URL = 'https://wwwcie.ups.com/ups.app/xml'

    def initialize(credentials, address = {})
      @credentials = credentials
    end

    protected

      def send_request(url, payload)
        full_request = @access_request_node.to_xml.to_s + payload.to_xml.to_s 
        uri          = URI.parse(url)
        http         = ::Net::HTTP.new(uri.host, 443)
        http.use_ssl = true
        http.post(uri.request_uri, full_request).body
      end



  end
end
