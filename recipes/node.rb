#
# Cookbook Name:: incident_bot
# Recipe:: node
#
# Copyright (C) 2016 Hearst Automation Team
#

node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = '4.4.2'
node.default['nodejs']['binary']['checksum'] = '003a8dcb3c267b9f268e9443ee2ae381bceaebee1cb438688cd52122591c9b56'

include_recipe "nodejs"
