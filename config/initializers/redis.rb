redis_config = Rails.application.config_for('redis').with_indifferent_access
REDIS = Redis.new(host: redis_config[:host], port: redis_config[:port], db: redis_config[:db])
