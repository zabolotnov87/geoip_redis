# frozen_string_literal: true
require "geoip_redis/store"
require "geoip_redis/csv_reader"
require "geoip_redis/blocks_parser"
require "geoip_redis/locations_parser"

module GeoipRedis
  class CountryLoader
    def initialize(redis)
      @store = Store.new(redis)
      @csv_reader = CSVReader.new
      @blocks_parser = BlocksParser.new
      @locations_parser = LocationsParser.new
    end

    def load_blocks(path_to_blocks)
      read_by_batch(path_to_blocks) do |rows|
        ip_ranges = rows.map { |row| @blocks_parser.ip_range(row) }
        @store.put_ip_ranges(ip_ranges)
      end
    end

    def load_locations(path_to_locations)
      read_by_batch(path_to_locations) do |rows|
        locations = rows.map { |row| @locations_parser.country(row) }
        @store.put_locations(locations)
      end
    end

    private

      def read_by_batch(path_to_file, &block)
        File.open(path_to_file) do |file|
          @csv_reader.read_by_batch(file) { |rows| block.call(rows) }
        end
      end
  end
end
