#
# Cookbook Name:: incident_bot
# Recipe:: hubot
#
# Copyright (C) 2016 Hearst Automation Team
#


%w(/opt/hubot /opt/hubot/redis /opt/hubot/config).each do |path|
  directory path do
    owner 'root'
    group 'root'
    recursive true
    mode 00775
  end
end

template '/opt/hubot/config/hubot.conf' do
  source 'hubot.conf.erb'
  owner 'root'
  group 'root'
  variables(
    slack_api_key:  ENV[SLACKAPI],
    pagerduty_apikey:  ENV[PDAPI],
    pagerduty_servicekey: ENV[PDSERVICE]
  )
  mode 00774
end
