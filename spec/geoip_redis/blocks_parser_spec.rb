require "spec_helper"
require "geoip_redis/blocks_parser"

describe GeoipRedis::BlocksParser do
  subject(:parser) { described_class.new }

  describe "#ip_range" do
    let(:location_id) { "234343" }
    let(:network) { "34.231.23.0/24" }
    let(:data) { [network, location_id] }

    before do
      expect(GeoipRedis::IpRange).to receive(:build_from_network)
        .with(network, location_id)
    end

    it "call IpRange.build_from_network(network, location_id)" do
      parser.ip_range(data)
    end
  end
end
