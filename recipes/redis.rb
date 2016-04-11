#
# Cookbook Name:: incident_bot
# Recipe:: redis
#
# Copyright (C) 2016 Hearst Automation Team
#


node.default["s3fs"]["mount_root"] = '/opt/redis_bucket'
node.default["s3fs"]["data"] = {
  "buckets" => [node['incident_bot']['aws']['redis_bucket']],
  "access_key_id" => node['incident_bot']['aws']['access_key'],
  "secret_access_key" => node['incident_bot']['aws']['secret_key']
}

L7_redis_pool 'incident_bot_brain' do
    port '6379'
    bind '0.0.0.0'
    databases 1
    datadir "/opt/redis_bucket/#{node['incident_bot']['aws']['redis_bucket']}"
end
