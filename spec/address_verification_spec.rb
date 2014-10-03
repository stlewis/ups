require 'spec_helper'


describe UPS::AddressVerification do

  it "succeeds on real addresses" do
    credentials      = {license_number: '0CD86BC5ABEA80F2', user_id: 'modusapi', password: '1qaz@WSX'}
    address          = {address_line1: '2134 Main Street', city: 'Huntington Beach', state: 'CA', zip: '92649', country: 'US' }
    verification     = UPS::AddressVerification.new(credentials, address)    
    is_valid_address = verification.verify
    
    expect(is_valid_address).to eq true
  end

  it "fails on fake addresses" do
    credentials      = {license_number: '0CD86BC5ABEA80F2', user_id: 'modusapi', password: '1qaz@WSX'}
    address          = {address_line1: '123 Any Street', city: 'Huntington Beach', state: 'CA', zip: '92649', country: 'US' }
    verification     = UPS::AddressVerification.new(credentials, address)    
    is_valid_address = verification.verify
    
    expect(is_valid_address).to eq false
    
  end
  
end
