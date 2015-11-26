require "spec_helper"
require "geoip_redis/locations_parser"

describe GeoipRedis::LocationsParser do
  subject(:parser) { described_class.new }

  describe "#country" do
    let(:country) do
      {
        location_id:      "23423",
        locale_code:      "en",
        continent_code:   "AF",
        continent_name:   "Africa",
        country_iso_code: "RW",
        country_name:     "Rwanda",
      }
    end

    let(:data) { country.values }

    it "build country from row of locations csv file" do
      expect(parser.country(data)).to eq country
    end
  end
end
