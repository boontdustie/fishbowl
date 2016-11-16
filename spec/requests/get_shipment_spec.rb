require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_shipment" do
    before :each do
      mock_tcp_connection
      mock_login_response

      configure_and_connect({ host: 'localhost', username: 'johndoe', password: 'secret' })
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_shipment(33)
      connection.last_write.should be_equivalent_to(expected_request)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.GetShipmentRq {
              xml.ShipmentID 33
            }
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.GetShipmentRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
