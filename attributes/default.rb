#
# Cookbook Name:: incident_bot
# Hubot Attributes
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

# AWS Placeholders
default['incident_bot']['aws'].tap do |aws|
  aws['redis_bucket'] = ''
  aws['secret_key'] = ''
  aws['access_key'] = ''
  aws['domain'] = ''
end

# Hubot config
default['incident_bot'].tap do |bot|
  bot['name'] = 'incident-bot'
  bot['adapter'] = 'slack'
  bot['git_source'] = 'https://github.com/github/hubot.git'
  bot['version'] = '2.18.0'
  bot['install_dir'] = "/opt/#{node['incident_bot']['name']}"
  bot['user'] = 'hubot'
  bot['group'] = 'hubot'
  bot['daemon'] = 'runit'
end

default['hubot']['dependencies'] = {
  "hubot-slack" => ">= 3.4.2",
  "hubot-redis-brain" => "0.0.3",
  "hubot-pager-me" => "2.1.13",
  "hubot-incident" => "0.1.2"
}

# Set Hubot Environment
default['incident_bot']['config'].tap do |config|
  config['HUBOT_NAME'] = node['incident_bot']['name']
  config['HUBOT_SLACK_TOKEN'] = ''
  config['HUBOT_PAGERDUTY_API_KEY'] = ''
  config['HUBOT_PAGERDUTY_SERVICE_API_KEY'] = ''
  config['HUBOT_PAGERDUTY_SUBDOMAIN'] = ''
  config['HUBOT_PAGERDUTY_USER_ID'] = ''
  config['HUBOT_PAGERDUTY_SERVICES'] = ''
end

# Script List
default['incident_bot']['external_scripts'] = ['hubot-incident', 'hubot-pager-me', 'hubot-redis-brain']

# letsencrypt Config
default['incident_bot']['letsencrypt']['contact'] = ''
default['incident_bot']['letsencrypt']['endpoint'] = 'https://acme-v01.api.letsencrypt.org'

default['incident_bot']['nginx'].tap do |nginx|
  nginx['site_name'] = node['incident_bot']['name']
  nginx['server_name_aliases'] = ["#{node['incident_bot']['name']}"]
  nginx['ssl']['crt_file'] = "#{node['incident_bot']['install_dir']}/ssl/#{node['incident_bot']['name']}.#{node['incident_bot']['aws']['domain']}.crt"
  nginx['ssl']['key_file'] = "#{node['incident_bot']['install_dir']}/ssl/#{node['incident_bot']['name']}.#{node['incident_bot']['aws']['domain']}.key"
end

# Set enpoint/servername
default['incident_bot']['endpoint'] = "#{node['incident_bot']['name']}.#{node['incident_bot']['aws']['domain']}"

# runit configure
default['incident_bot']['runit']['default_logger'] = true # Use true to log to /var/log/hubot

# Supervisor configure
default['incident_bot']['supervisor'].tap do |supervisor|
  supervisor['stdout_logfile'] = '/var/log/hubot.log'
  supervisor['stdout_logfile_maxbytes'] = '10MB'
  supervisor['stdout_logfile_backups'] = 10
  supervisor['stderr_logfile'] = '/var/log/hubot_error.log'
  supervisor['stderr_logfile_maxbytes'] = '10MB'
  supervisor['stderr_logfile_backups'] = 10
end
