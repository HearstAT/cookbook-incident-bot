#
# Cookbook Name:: incident_bot
# Recipe:: default
#
# Copyright (C) 2016 Hearst Automation Team
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

node.default['incident_bot']['aws'].tap do |aws|
  aws['redis_bucket'] = ENV['AWS_REDIS_BUCKET']
  aws['secret_key'] = ENV['AWS_SECRET_KEY']
  aws['access_key'] = ENV['AWS_ACCESS_KEY']
  aws['domain'] = ENV['AWS_DOMAIN']
end

node.default['incident_bot']['config'].tap do |config|
  config['HUBOT_NAME'] = node['incident_bot']['name']
  config['HUBOT_SLACK_TOKEN'] = ENV['SLACK_TOKEN']
  config['HUBOT_PAGERDUTY_API_KEY'] = ENV['PAGERDUTY_API_KEY']
  config['HUBOT_PAGERDUTY_SERVICE_API_KEY'] = ENV['PAGERDUTY_SERVICE_API_KEY']
  config['HUBOT_PAGERDUTY_SUBDOMAIN'] = ENV['PAGERDUTY_SUBDOMAIN']
  config['HUBOT_PAGERDUTY_USER_ID'] = ENV['PAGERDUTY_USER_ID']
  config['HUBOT_PAGERDUTY_SERVICES'] = ENV['PAGERDUTY_SERVICES']
end

include_recipe 'apt::default'
include_recipe 'incident_bot::node' # Hubot runs on node and coffee!
include_recipe 'incident_bot::redis' # Setup Redis to support Hubot Brain
include_recipe 'incident_bot::hubot' # Install & Configure HUBOT!
include_recipe 'incident_bot::nginx' # Create SSL Endpoint for Hubot HTTP Listener
