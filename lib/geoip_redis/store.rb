require "redis"

require "geoip_redis/ip_range"

module GeoipRedis
  class Store
    IP_RANGES_KEY = "geoip:ipranges"

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

    private

      def put_ip_range(ip_range)
        @redis.zadd(IP_RANGES_KEY, ip_range.max_ip_num, ip_range.encode)
      end
  end
end
