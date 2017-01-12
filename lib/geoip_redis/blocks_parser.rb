# frozen_string_literal: true
require "geoip_redis/ip_range"

module GeoipRedis
  class BlocksParser

    CIDR = 0
    GEONAME_ID = 1
    private_constant :CIDR, :GEONAME_ID

    def ip_range(data)
      location_id = data[GEONAME_ID]
      cidr = data[CIDR]
      IpRange.build_from_network(cidr, location_id)
    end

    POSTAL_CODE = 6
    LATITUDE    = 7
    LONGITUDE   = 8
    private_constant :POSTAL_CODE, :LATITUDE, :LONGITUDE

    def location(data)
      {
        location_id: data[GEONAME_ID],
        postal_code: data[POSTAL_CODE],
        latitude:    data[LATITUDE],
        longitude:   data[LONGITUDE],
      }
    end
  end
end
