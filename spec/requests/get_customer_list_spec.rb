require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_customer_list" do
    before :each do
      mock_tcp_connection
      mock_login_response

      configure_and_connect({ host: 'localhost', username: 'johndoe', password: 'secret' })
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_customer_list
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "returns an array of customers" do
      mock_the_response(expected_response)
      response = Fishbowl::Requests.get_customer_list

      response.should be_an(Array)
      response.first.should be_a(Fishbowl::Objects::Customer)
    end

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.CustomerListRq
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.CustomerListRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
