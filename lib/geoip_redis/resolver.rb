# frozen_string_literal: true
require "ipaddr"

require "geoip_redis/store"

module GeoipRedis
  class Resolver
    def initialize(redis)
      @store = Store.new(redis)
    end

    def resolve(ip)
      ip_num = normalize_ip(ip).to_i
      ip_range = @store.find_ip_range(ip_num)

      return if ip_range.nil? || !ip_range.member?(ip_num)

      @store.find_location(ip_range.location_id)
    end

    private

      def normalize_ip(ip)
        case ip
        when String
          IPAddr.new(ip)
        when Numeric
          IPAddr.new(ip, Socket::AF_INET)
        else
          ip
        end
      end
  end
end
