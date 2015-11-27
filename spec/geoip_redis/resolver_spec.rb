require "spec_helper"
require "geoip_redis/resolver"

describe GeoipRedis::Resolver do
  let(:store) { double }

  subject(:resolver) do
    described_class.new(redis_test_connection).tap do |resolver|
      resolver.instance_variable_set(:@store, store)
    end
  end

  let(:ip) { "193.234.23.13" }
  let(:ip_num) { build_ip_num(ip) }

  describe "#resolve" do
    context "when ip range can't be found" do
      before do
        expect(store).to receive(:find_ip_range).with(ip_num).and_return(nil)
      end

      it "return nil" do
        expect(resolver.resolve(ip)).to be_nil
      end
    end

    context "when ip range can be found" do
      let(:location_id) { "23235" }
      let(:ip_range) { double(location_id: location_id) }
      let(:location) { double }

      before do
        expect(store).to receive(:find_ip_range).with(ip_num)
          .and_return(ip_range)
      end

      context "ip range include ip" do
        before do
          expect(ip_range).to receive(:member?).with(ip_num).and_return(true)

          expect(store).to receive(:find_location).with(location_id)
            .and_return(location)
        end

        it "return location" do
          expect(resolver.resolve(ip)).to eq location
        end
      end

      context "ip range doesn't include ip" do
        before do
          expect(ip_range).to receive(:member?).with(ip_num).and_return(false)
        end

        it "return nil" do
          expect(resolver.resolve(ip)).to be_nil
        end
      end
    end
  end

end
