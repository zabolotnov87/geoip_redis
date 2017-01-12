# frozen_string_literal: true
require File.join(__dir__, "lib", "geoip_redis", "version")

Gem::Specification.new do |spec|
  spec.name        = "geoip_redis"
  spec.version     = GeoipRedis::VERSION
  spec.authors     = ["Sergey Zabolotnov"]
  spec.email       = ["sergey.zabolotnov@gmail.com"]

  spec.summary     = "Put MaxMind GeoIP2 database to Redis"
  spec.description = "Put MaxMind GeoIP2 database to Redis"
  spec.homepage    = "https://github.com/zabolotnov87/geoip_redis"
  spec.license     = "MIT"

  spec.files       = Dir["lib/**/*.rb"] + %w(README.md LICENSE.txt)

  spec.add_dependency "redis", "~> 3.3"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "pry-byebug", "~> 3.4"
end
