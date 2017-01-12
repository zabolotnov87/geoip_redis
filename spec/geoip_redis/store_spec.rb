require "spec_helper"
require "geoip_redis/store"
require "geoip_redis/ip_range"

describe GeoipRedis::Store do
  let(:redis) { redis_test_connection }
  subject(:store) { described_class.new(redis) }

  def build_ip_range(network)
    GeoipRedis::IpRange.build_from_network(network, "some location id")
  end

  describe "put and find ip ranges" do
    let(:network) { "211.34.0.0/16" }
    let(:ip_range) { build_ip_range(network) }
    let(:ip_ranges) { [ip_range] }

    before do
      store.put_ip_ranges(ip_ranges)
    end

    context "when ip <= stored_ip_range.max_ip" do
      let(:ip_num) { build_ip_num("211.34.14.32") }

      it "return stored ip range" do
        expect(store.find_ip_range(ip_num).encode).to eq ip_range.encode
      end
    end

    context "when ip > stored_ip_range.max_ip" do
      let(:ip_num) { build_ip_num("219.45.23.12") }

      it "return nil" do
        expect(store.find_ip_range(ip_num)).to be_nil
      end
    end
  end

  describe "put and find location" do
    let(:location_id) { "2324234" }
    let(:location) do
      {
        "country" => "Russia",
        "city"    => "Moscow",
      }
    end

    let(:location_to_store) { {location_id: location_id}.merge(location) }
    let(:locations_to_store) { [location_to_store] }

    before do
      store.put_locations(locations_to_store)
    end

    it "return location" do
      expect(store.find_location(location_id)).to eq location
    end
  end

end
