require "ipaddr"

module GeoipRedis
  IpRange = Struct.new(:location_id, :min_ip, :max_ip) do

    def self.build(cidr, location_id)
      ip_range = IPAddr.new(cidr).to_range
      new(location_id, ip_range.first, ip_range.last)
    end

  end
end
