#
# Cookbook Name:: incident_bot
# Recipe:: node
#
# Copyright (C) 2016 Hearst Automation Team
#

node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = '4.4.2'
node.default['nodejs']['binary']['checksum'] = '99c4136cf61761fac5ac57f80544140a3793b63e00a65d4a0e528c9db328bf40'
node.default['nodejs']['npm']['version'] = '2.15.2'
