require "spec_helper"
require "geoip_redis/ip_range"

describe GeoipRedis::IpRange do
  let(:min_ip_num) { build_ip_num("193.145.15.0") }
  let(:max_ip_num) { build_ip_num("193.145.15.255") }
  let(:network) { "193.145.15.0/24" }
  let(:location_id) { "34521" }

  describe "::build" do
    it "build instance from cidr-notation network" do
      ip_range = described_class.build_from_network(network, location_id)

      expect(ip_range.location_id).to eq location_id
      expect(ip_range.min_ip_num).to eq min_ip_num
      expect(ip_range.max_ip_num).to eq max_ip_num
    end
  end

  let(:encoded_ip_range) { "#{location_id}:#{min_ip_num}:#{max_ip_num}" }
  let(:ip_range) { described_class.new(location_id, min_ip_num, max_ip_num) }

  describe "#encode" do
    it "return encoded ip range" do
      expect(ip_range.encode).to eq encoded_ip_range
    end
  end

  describe "::decode" do
    it "decode string and return ip range" do
      expect(described_class.decode(encoded_ip_range)).to eq ip_range
    end
  end

  describe "#member?" do
    context "when ip is in range" do
      ips = %w(
        193.145.15.0
        193.145.15.45
        193.145.15.255
      )

      ips.each do |ip|
        let(:ip_num) { build_ip_num(ip) }

        it "return true" do
          expect(ip_range.member?(ip_num)).to eq true
        end
      end
    end

    context "when ip is out of range" do
      let(:ip_num) { build_ip_num("193.145.16.4") }

      it "should return false" do
        expect(ip_range.member?(ip_num)).to eq false
      end
    end
  end
end
