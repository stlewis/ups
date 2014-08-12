require 'spec_helper'
require 'base64'


describe UPS::Shipment do
  
  it 'works as you would expect' do
      credentials     = {license_number: '0CD86BC5ABEA80F2', user_id: 'modusapi', password: '1qaz@WSX'}
      package         = {
                          reference_number: {code: 'SE', value: '27030483028402384'},
                          packaging_type: {code: '02'},
                          package_weight: {code: 'LBS', weight: '1'},
                          description: "Calamp LMU3030"
                        }
      shipment_params = {
                          label_specification: {code: 'GIF', label_width: 6 },
                          return_service: {code: '9'},
                          request: {request_option: 'nonvalidate'},
                          shipper: {
                                     name: "Joe Blow",
                                     shipper_number: 'W82Y64',
                                     address: {
                                                address_line1: '2134 Main St.',
                                                address_line2: 'Ste 230',
                                                city: 'Huntington Beach',
                                                state: 'CA',
                                                postal_code: '92649'
                                              }
                                   },
                          ship_to: {
                                     company_name: 'Modus', 
                                     attention_name: "Esurance Returns",
                                     address: {
                                                address_line1: '16421 Goddard St', 
                                                address_line2: 'Ste B',
                                                city: 'Huntington Beach',
                                                state: 'CA',
                                                postal_code: '92647',
                                                country_code: 'US'
                                              }
                                   
                                   },

                          ship_from: {
                                     company_name: 'Jacqapo Smegeddly', 
                                     address: {
                                                address_line1: '1624 4th St.', 
                                                city: 'Madison',
                                                state: 'IL',
                                                postal_code: '62060',
                                                country_code: 'US'
                                              }
                                   
                                   },
                          service: {code: '03'},
                          payment_info: { bill_3rd_party_info: {
                                                                 account_number: 'R41Y84',
                                                                 address: {
                                                                            postal_code: '92649',
                                                                            country_code: 'US'
                                                                          }
                                                               } 
                                        }
                        
                        } 
      packages = [package]
      shipment = UPS::Shipment.new(credentials, packages, shipment_params)
      result   = shipment.create
      File.write '/Users/stlewis/Projects/scratch/label.html', Base64::decode64(shipment.html_image)
  end


end
