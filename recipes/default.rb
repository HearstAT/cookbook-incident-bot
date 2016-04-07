#
# Cookbook Name:: incident_bot
# Recipe:: default
#
# Copyright (C) 2016 Hearst Automation Team
#

include_recipe 'incident_bot::node'
include_recipe 'incident_bot::hubot'
include_recipe 'incident_bot::scripts'
