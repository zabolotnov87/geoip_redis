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

  describe "#city" do
    let(:city) do
      {
        location_id:            "23452",
        locale_code:            "en",
        continent_code:         "AS",
        continent_name:         "Asia",
        country_iso_code:       "IL",
        country_name:           "Israel",
        subdivision_1_iso_code: "M",
        subdivision_1_name:     "Central District",
        subdivision_2_iso_code: nil,
        subdivision_2_name:     nil,
        city_name:              "Mazor",
        metro_code:             "234ad",
        time_zone:              "Asia/Jerusalem",
      }
    end

    let(:data) do
      city.values
    end

    it "build city from row of locations csv file" do
      expect(parser.city(data)).to eq city
    end
  end
end
