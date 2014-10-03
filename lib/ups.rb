require 'nokogiri'
require 'net/http'

require "ups/version"
require "ups/request"
require "ups/shipment"
require "ups/address_verification"
require "ups/xml_generator/request_xml/base.rb"
require 'ups/response/confirm_response'
require 'ups/response/accept_response'
require 'ups/response/address_validation_response'

Dir.glob(File.dirname(__FILE__) + '/ups/xml_generator/request_xml/*.rb'){|ff| require ff }


module UPS
end
