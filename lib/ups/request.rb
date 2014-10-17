module UPS
  class Request

    def initialize(credentials, api_options = {})
      @credentials = credentials
      @env = api_options[:env]
    end

    def api_url
      @env == 'development' ? 'https://wwwcie.ups.com/ups.app/xml' : 'https://onlinetools.ups.com/ups.app/xml'
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
