require "spec_helper"
require "geoip_redis/country_loader"
require "geoip_redis/resolver"

describe "Resolve country by ip" do
  let(:redis) { redis_test_connection }
  let(:loader) { GeoipRedis::CountryLoader.new(redis) }
  let(:resolver) { GeoipRedis::Resolver.new(redis) }
  let(:path_to_blocks) { "#{__dir__}/fixtures/country_blocks_ipv4.csv" }
  let(:path_to_locations) { "#{__dir__}/fixtures/country_locations.csv" }

  before do
    loader.load_blocks(path_to_blocks)
    loader.load_locations(path_to_locations)
  end

  context "when ip is in ip range" do
    let(:ip) { "34.231.23.44" }
    let(:country) do
      {
        "locale_code"      => "en",
        "continent_code"   => "AF",
        "continent_name"   => "Africa",
        "country_iso_code" => "RW",
        "country_name"     => "Rwanda",
      }
    end

    it "resolve country" do
      expect(resolver.resolve(ip)).to eq country
    end
  end

  context "when ip is out of any ip ranges" do
    let(:ip) { "194.43.23.14" }

    it "can't resolve country" do
      expect(resolver.resolve(ip)).to be_nil
    end
  end
end
