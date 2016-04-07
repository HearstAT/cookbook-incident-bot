#
# Cookbook Name:: incident_bot
# Recipe:: scripts
#
# Copyright (C) 2016 Hearst Automation Team
#


template '/opt/hubot/external-scripts.json' do
  source 'external-scripts.json.erb'
  owner 'root'
  group 'root'
  mode 00774
end

nodejs_npm "hubot-incident" do
  version "0.1.0"
end
