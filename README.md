## Usage

working with GeoIP2 Country database:
* load:

```ruby
require "redis"
require "geoip_redis/country_loader"

redis = Redis.new(url: "redis://localhost:6379/4")
loader = GeoipRedis::CountryLoader.new(redis)

loader.load_blocks("path/to/blocks_ipv4.csv")
loader.load_locations("path/to/locations.csv")
```

* resolve country by ip:

```ruby
require "redis"
require "geoip_redis/resolver"

redis = Redis.new(url: "redis://localhost:6379/4")
resolver = GeoipRedis::Resolver.new(redis)

country = resolver.resolve("123.234.23.12")
```

working with GeoIP2 City database:
* load:

```ruby
require "redis"
require "geoip_redis/city_loader"

redis = Redis.new(url: "redis://localhost:6379/5")
loader = GeoipRedis::CityLoader.new(redis)

loader.load_blocks("path/to/blocks_ipv4.csv")
loader.load_locations("path/to/locations.csv")
```

* resolve city by ip:

```ruby
require "redis"
require "geoip_redis/resolver"

redis = Redis.new(url: "redis://localhost:6379/5")
resolver = GeoipRedis::Resolver.new(redis)

city = resolver.resolve("123.234.23.12")
```
