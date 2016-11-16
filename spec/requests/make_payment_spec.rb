require 'spec_helper'

describe Fishbowl::Requests do
  describe "#make_payment" do
    before :each do
      mock_tcp_connection
      mock_login_response

      configure_and_connect({ host: 'localhost', username: 'johndoe', password: 'secret' })
    end

    let(:connection) { FakeTCPSocket.instance }

    let(:valid_options) {
      #TODO figure out valid options
    }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.make_payment(valid_options)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.MakePaymentRq {
              xml.Payment #TODO mock Payment object
              xml.ProcessPayment true
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.MakePaymentRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
