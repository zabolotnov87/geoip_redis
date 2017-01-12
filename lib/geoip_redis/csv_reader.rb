# frozen_string_literal: true
require "csv"

module GeoipRedis
  class CSVReader

    HEADER = 1
    private_constant :HEADER

    def read_by_batch(io, batch_size: 1000, &block)
      batch = []
      CSV.new(io).each.lazy.drop(HEADER).each_with_index do |row, idx|
        batch << row
        if (idx + 1) % batch_size == 0
          block.call(batch)
          batch = []
        end
      end

      block.call(batch) unless batch.empty?
    end

  end
end
