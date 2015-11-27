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

  describe "#location" do
    let(:data) do
      [anything, "234"] + Array.new(4, anything) + %w(23452 34.1033 12.2331)
    end

    let(:location) do
      {
        location_id: "234",
        postal_code: "23452",
        latitude:    "34.1033",
        longitude:   "12.2331",
      }
    end

    it "build location from row of blocks csv file" do
      expect(parser.location(data)).to eq location
    end
  end
end
