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

# Hubot config
default['incident_bot'].tap do |bot|
  bot['name'] = ENV['HUBOT_NAME'] || 'incident-bot'
  bot['adapter'] = 'slack'
  bot['git_source'] = ENV['HUBOT_SOURCE'] ||'https://github.com/github/hubot.git'
  bot['version'] = ENV['HUBOT_VERSION'] ||'2.18.0'
  bot['install_dir'] = ENV['HUBOT_DIR'] || '/opt/incident_bot'
  bot['user'] =  ENV['HUBOT_USER'] || ENV['HUBOT_NAME'] || 'hubot'
  bot['group'] = ENV['HUBOT_GROUP'] || ENV['HUBOT_NAME'] || 'hubot'
  bot['daemon'] = ENV['HUBOT_GROUP'] || 'runit'
end

default['hubot']['dependencies'] = {
  "hubot-slack" => ">= 3.4.2",
  "hubot-pager-me" => "2.1.13",
  "hubot-incident" => "0.1.2"
}

# Set Hubot Environment
default['incident_bot']['config'] = {
  "HUBOT_NAME" => node['incident_bot']['name'],
  "HUBOT_SLACK_TOKEN" => ENV['SLACK_TOKEN'],
  "HUBOT_PAGERDUTY_API_KEY" => ENV['PAGERDUTY_API_KEY'],
  "HUBOT_PAGERDUTY_SERVICE_API_KEY" => ENV['PAGERDUTY_SERVICE_API_KEY'],
  "HUBOT_PAGERDUTY_SUBDOMAIN" => ENV['PAGERDUTY_SUBDOMAIN'],
  "HUBOT_PAGERDUTY_USER_ID" => ENV['PAGERDUTY_USER_ID'],
  "HUBOT_PAGERDUTY_SERVICES" => ENV['PAGERDUTY_SERVICES']
}

# Script List
default['incident_bot']['external_scripts'] = ['hubot-incident', 'hubot-pager-me']

default['incident_bot']['nginx'].tap do |nginx|
  nginx['site_name'] = node['incident_bot']['name']
  nginx['server_name_aliases'] = ["#{node['incident_bot']['name']}"]
  nginx['ssl']['crt_file'] = "/opt/hubot/ssl/#{node['incident_bot']['name']}.#{ENV['DOMAIN']}.crt"
  nginx['ssl']['key_file'] = "/opt/hubot/ssl/#{node['incident_bot']['name']}.#{ENV['DOMAIN']}.key"
end

# Choose daemonize program: 'runit' or 'supervisor'
default['incident_bot']['daemon'] = ENV['HUBOT_DAEMON'] || 'runit'

# runit configure
default['incident_bot']['runit']['default_logger'] = ENV['RUNIT_LOGGER'] || false # Use true to log to /var/log/hubot

# Supervisor configure
default['incident_bot']['supervisor'].tap do |supervisor|
  supervisor['stdout_logfile'] = '/var/log/hubot.log'
  supervisor['stdout_logfile_maxbytes'] = '10MB'
  supervisor['stdout_logfile_backups'] = 10
  supervisor['stderr_logfile'] = '/var/log/hubot_error.log'
  supervisor['stderr_logfile_maxbytes'] = '10MB'
  supervisor['stderr_logfile_backups'] = 10
end