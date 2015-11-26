require "geoip_redis/ip_range"

module GeoipRedis
  class BlocksParser

    CIDR = 0
    GEONAME_ID = 1
    private_constant :CIDR, :GEONAME_ID

    def ip_range(data)
      location_id = data[GEONAME_ID]
      cidr = data[CIDR]
      IpRange.build(cidr, location_id)
    end
  end
end
