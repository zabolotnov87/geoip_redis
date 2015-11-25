require "spec_helper"
require "geoip_redis/csv_reader"

describe GeoipRedis::CSVReader do
  subject(:reader) { described_class.new }

  let(:processor) { spy }

  let(:io) { StringIO.new <<-CSV.gsub(/^\s+/, "") }
    column1,column2
    value_1,value_2
    value_1,value_2
    value_1,value_2
  CSV

  let(:header) { %w(column1 column2) }
  let(:rows) { Array.new(2, %w(value_1 value_2)) }
  let(:last_rows) { [%w(value_1 value_2)] }

  describe "#read_batch" do
    it "skip header and call block with batch of rows" do
      reader.read_by_batch(io, batch_size: 2) { |rows| processor.process(rows) }

      expect(processor).to have_received(:process).once.with(rows)
      expect(processor).to have_received(:process).once.with(last_rows)
      expect(processor).not_to have_received(:process).with(header)
    end
  end
end
