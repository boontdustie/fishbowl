require 'spec_helper'

describe Fishbowl::Requests do
  describe "#get_work_order_list" do
    before :each do
      mock_tcp_connection
      mock_login_response

      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
      Fishbowl::Connection.connect(host: 'localhost')
      Fishbowl::Connection.login(username: 'johndoe', password: 'secret')
    end

    let(:connection) { FakeTCPSocket.instance }

    it "sends proper request" do
      mock_the_response(expected_response)
      Fishbowl::Requests.get_work_order_list
      connection.last_write.should be_equivalent_to(expected_request)
    end

    it "returns and array of WorkOrders"

    def expected_request
      request = Nokogiri::XML::Builder.new do |xml|
        xml.FbiXml {
          xml.Ticket
          xml.FbiMsgsRq {
            xml.WorkOrderListRq
          }
        }
      end

      request.to_xml
    end

    def expected_response
      Nokogiri::XML::Builder.new do |xml|
        xml.response {
          xml.WorkOrderListRs(statusCode: '1000', statusMessage: "Success!") {
            #TODO figure out what goes here!
          }
        }
      end
    end
  end
end
