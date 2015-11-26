require "ipaddr"

require "spec_helper"
require "geoip_redis/ip_range"

describe GeoipRedis::IpRange do
  describe "::build" do
    let(:cidr) { "193.145.15.0/24" }
    let(:min_ip) { IPAddr.new("193.145.15.0") }
    let(:max_ip) { IPAddr.new("193.145.15.255") }
    let(:location_id) { "34521" }

    it "build instance from cidr-notation network" do
      ip_range = described_class.build(cidr, location_id)

      expect(ip_range.location_id).to eq location_id
      expect(ip_range.min_ip).to eq min_ip
      expect(ip_range.max_ip).to eq max_ip
    end
  end
end
