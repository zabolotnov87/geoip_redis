# frozen_string_literal: true
require "ipaddr"

module GeoipRedis
  class IpRange
    attr_reader :location_id, :min_ip_num, :max_ip_num

    def initialize(location_id, min_ip_num, max_ip_num)
      @location_id = location_id
      @min_ip_num  = min_ip_num
      @max_ip_num  = max_ip_num
    end

    def self.build_from_network(network, location_id)
      ip_range = IPAddr.new(network).to_range
      min_ip_num, max_ip_num = ip_range.first.to_i, ip_range.last.to_i
      new(location_id, min_ip_num, max_ip_num)
    end

    def self.decode(encoded)
      location_id, min_ip_num, max_ip_num = encoded.split(":")
      min_ip_num, max_ip_num = min_ip_num.to_i, max_ip_num.to_i
      new(location_id, min_ip_num, max_ip_num)
    end

    def encode
      "#{location_id}:#{min_ip_num}:#{max_ip_num}"
    end

    def member?(ip_num)
      (min_ip_num..max_ip_num).member?(ip_num)
    end

  end
end
