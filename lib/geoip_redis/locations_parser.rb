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
  end
end
