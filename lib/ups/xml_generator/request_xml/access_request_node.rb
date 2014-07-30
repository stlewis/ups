module UPS
  module RequestXML
    
    class AccessRequestNode < Base
      attr_reader :license_number, :user_id, :password

      def to_xml
        request = Nokogiri::XML::Builder.new do |xml|
          
          xml.AccessRequest {
            xml.AccessLicenseNumber @license_number
            xml.UserId @user_id
            xml.Password @password
          }
        
        end
        
        return request.to_xml
      end


    end
  end
end
