# GeoipRedis
Puts MaxMind GeoIP2 database to Redis and allows to resolve country/city by ip. The main idea described [here](http://redis4you.com/articles.php?id=018&name=GeoIP+in+Redis).

## Restrictions
 * lagacy version of GeoIP database isn't supported
 * working only with IPv4 database

## Installation
Add this line to your application's Gemfile:

```ruby
gem "geoip_redis"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis_geoip

## Usage

Working with GeoIP2 Country database:
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

Working with GeoIP2 City database:
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

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/zabolotnov87/geoip_redis. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Licence
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
