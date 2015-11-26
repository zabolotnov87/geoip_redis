require "ipaddr"

require "spec_helper"
require "geoip_redis/blocks_parser"
require "geoip_redis/ip_range"

describe GeoipRedis::BlocksParser do
  subject(:parser) { described_class.new }

  describe "#ip_range" do
    let(:data) { %w(34.231.23.0/24 2077456) }
    let(:ip_range) do
      min_ip = IPAddr.new("34.231.23.0")
      max_ip = IPAddr.new("34.231.23.255")
      GeoipRedis::IpRange.new("2077456", min_ip, max_ip)
    end

    it "build ip range from row of blocks csv file" do
      expect(parser.ip_range(data)).to eq ip_range
    end
  end
end
