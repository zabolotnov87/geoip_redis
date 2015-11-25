require "redis"

redis_db = ENV["REDIS_TEST_DB"] || 7
REDIS_TEST_CONNECTION = Redis.new(url: "redis://localhost:6379/#{redis_db}")

def redis_test_connection
  REDIS_TEST_CONNECTION
end

if redis_test_connection.keys("*").size > 0
  warn <<-WARNING
Warning! These tests use database #{redis_db} on your local redis instance.
Your database seems to have keys on it.
Please clear them before running the tests or set the
environment variable REDIS_TEST_DB to use a different database number.
  WARNING

  exit
end

RSpec.configure do |config|
  config.before(:each) do
    redis_test_connection.flushdb
  end

  config.after(:each) do
    redis_test_connection.flushdb
  end
end
