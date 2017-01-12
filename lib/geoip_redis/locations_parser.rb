# frozen_string_literal: true
module GeoipRedis
  class LocationsParser
    def country(data)
      geoname_id, locale_code, continent_code, continent_name,
        country_iso_code, country_name = data

      {
        location_id:      geoname_id,
        locale_code:      locale_code,
        continent_code:   continent_code,
        continent_name:   continent_name,
        country_iso_code: country_iso_code,
        country_name:     country_name,
      }
    end

    SUBDIVISION_1_ISO_CODE = 6
    private_constant :SUBDIVISION_1_ISO_CODE

    def city(data)
      subdivision_1_iso_code, subdivision_1_name, subdivision_2_iso_code,
        subdivision_2_name, city_name, metro_code, time_zone =
        data[SUBDIVISION_1_ISO_CODE..-1]

      location = {
        subdivision_1_iso_code: subdivision_1_iso_code,
        subdivision_1_name:     subdivision_1_name,
        subdivision_2_iso_code: subdivision_2_iso_code,
        subdivision_2_name:     subdivision_2_name,
        city_name:              city_name,
        metro_code:             metro_code,
        time_zone:              time_zone,
      }

      country(data).merge(location)
    end
  end
end
