#
# Cookbook Name:: incident_bot
# Recipe:: redis
#
# Copyright (C) 2016 Hearst Automation Team
#


node.default["s3fs"]["mount_root"] = '/opt/redis_bucket'
node.default["s3fs"]["data"] = {
  "buckets" => [ENV['REDIS_BUCKET']]
  "access_key_id" => ENV['SECRET_KEY']
  "secret_access_key" => ENV['ACCESS_KEY']
}

L7_redis_pool 'incident_bot_brain' do
    port '6379'
    bind '0.0.0.0'
    databases 1
    datadir "/opt/redis_bucket/#{ENV['REDIS_BUCKET']}"
end
