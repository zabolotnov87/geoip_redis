require "spec_helper"
require "geoip_redis/ip_range"

describe GeoipRedis::IpRange do
  let(:min_ip_num) { build_ip_num("193.145.15.0") }
  let(:max_ip_num) { build_ip_num("193.145.15.255") }
  let(:location_id) { "34521" }
  let(:ip_range) { described_class.new(location_id, min_ip_num, max_ip_num) }
  let(:encoded_ip_range) { "#{location_id}:#{min_ip_num}:#{max_ip_num}" }

  describe "::build" do
    let(:network) { "193.145.15.0/24" }
    subject { described_class.build_from_network(network, location_id) }

    it "build instance from cidr-notation network" do
      expect(subject.location_id).to eq location_id
      expect(subject.min_ip_num).to  eq min_ip_num
      expect(subject.max_ip_num).to  eq max_ip_num
    end
  end

  describe "::decode" do
    subject { described_class.decode(encoded_ip_range) }

    it "decode string and return ip range" do
      expect(subject.location_id).to eq location_id
      expect(subject.min_ip_num).to  eq min_ip_num
      expect(subject.max_ip_num).to  eq max_ip_num
    end
  end

  describe "#encode" do
    subject { ip_range.encode }

    it "return encoded ip range" do
      is_expected.to eq encoded_ip_range
    end
  end

  describe "#member?" do
    subject { ip_range.member?(ip_num) }

    context "when ip is in range" do
      %w(
        193.145.15.0
        193.145.15.45
        193.145.15.255
      ).each do |ip|
        let(:ip_num) { build_ip_num(ip) }

        it { is_expected.to eq true }
      end
    end

    context "when ip is out of range" do
      let(:ip_num) { build_ip_num("193.145.16.4") }

      it { is_expected.to eq false }
    end
  end
end
