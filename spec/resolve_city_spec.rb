require "spec_helper"
require "geoip_redis/city_loader"
require "geoip_redis/resolver"

describe "Resolve city by ip" do
  let(:redis) { redis_test_connection }
  let(:loader) { GeoipRedis::CityLoader.new(redis) }
  let(:resolver) { GeoipRedis::Resolver.new(redis) }
  let(:path_to_blocks) { "#{__dir__}/fixtures/city_blocks_ipv4.csv" }
  let(:path_to_locations) { "#{__dir__}/fixtures/city_locations.csv" }

  before do
    loader.load_blocks(path_to_blocks)
    loader.load_locations(path_to_locations)
  end

  context "when ip is in ip range" do
    let(:ip) { "34.231.23.44" }
    let(:city) do
      {
        "locale_code"            => "en",
        "continent_code"         => "AS",
        "continent_name"         => "Asia",
        "country_iso_code"       => "IL",
        "country_name"           => "Israel",
        "subdivision_1_iso_code" => "M",
        "subdivision_1_name"     => "Central District",
        "subdivision_2_iso_code" => "",
        "subdivision_2_name"     => "",
        "city_name"              => "Mazor",
        "metro_code"             => "",
        "time_zone"              => "Asia/Jerusalem",
        "postal_code"            => "34523",
        "latitude"               => "32.0533",
        "longitude"              => "34.9275",
      }
    end

    it "resolve city" do
      expect(resolver.resolve(ip)).to eq city
    end
  end

  context "when ip is out of any ip ranges" do
    let(:ip) { "194.43.23.14" }

    it "can't resolve city" do
      expect(resolver.resolve(ip)).to be_nil
    end
  end
end
