# frozen_string_literal: true
require "redis"

require "geoip_redis/ip_range"

module GeoipRedis
  class Store
    IP_RANGES_KEY = "geoip:ipranges"
    LOCATIONS_KEY = "geoip:locations"

    def initialize(redis)
      @redis = redis
    end

    def put_ip_ranges(ip_ranges)
      @redis.pipelined do
        ip_ranges.each { |ip_range| put_ip_range(ip_range) }
      end
    end

    def find_ip_range(ip_num)
      encoded_ip_range = @redis.zrangebyscore(
        IP_RANGES_KEY, ip_num, "+inf", limit: [0, 1]).first

      IpRange.decode(encoded_ip_range) if encoded_ip_range
    end

    def put_locations(locations)
      @redis.pipelined do
        locations.each { |location| put_location(location) }
      end
    end

    def find_location(location_id)
      @redis.hgetall location_key(location_id)
    end

    private

      def put_ip_range(ip_range)
        @redis.zadd(IP_RANGES_KEY, ip_range.max_ip_num, ip_range.encode)
      end

      def put_location(location)
        location_id = location.fetch(:location_id)
        location.delete(:location_id)
        @redis.hmset location_key(location_id), location.flatten
      end

      def location_key(location_id)
        "#{LOCATIONS_KEY}:#{location_id}"
      end
  end
end
