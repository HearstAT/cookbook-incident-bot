#
# Cookbook Name:: incident_bot
# Hubot Attributes
#
# Copyright (C) 2016 Hearst Automation Team
#

# Hubot Config File Options
default['incident_bot']['name'] = ENV['BOTNAME']

default['incident_bot']['scripts'] = ['hubot-incident','hubot-pager-me']

# Pagerduty Settings if enable == false these won't matter
default['incident_bot']['pagerduty'].tap do |pdsettings|
  pdsettings['subdomain'] = ENV['PDSUBDOMAIN']
  pdsettings['account'] = ENV['PDACCOUNT']
  pdsettings['services'] = ENV['PDSERVICES']
end
