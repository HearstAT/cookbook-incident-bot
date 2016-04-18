#
# Cookbook Name:: incident_bot
# Recipe:: incident_bot
#
# Copyright (C) 2016 Hearst Automation Team
#

user node['incident_bot']['user'] do
  comment 'Hubot User'
  home node['incident_bot']['install_dir']
end

group node['incident_bot']['group'] do
  members [node['incident_bot']['user']]
end

directory node['incident_bot']['install_dir'] do
  owner node['incident_bot']['user']
  group node['incident_bot']['group']
  recursive true
  mode '0777'
end

git ::File.join(Chef::Config[:file_cache_path], 'hubot') do
  repository node['incident_bot']['git_source']
  revision "v#{node['incident_bot']['version']}"
  notifies :install, 'nodejs_npm[hubot]', :immediately
end

nodejs_npm 'hubot' do
  path ::File.join(Chef::Config[:file_cache_path], 'hubot')
  json true
  user 'root'
  group 'root'
  action :nothing
end

# Get the daemonizing server
daemon = node['incident_bot']['daemon']

# Script Deps
%w(libexpat1 libexpat1-dev libicu-dev).each do |pkg|
  package pkg do
    action :install
  end
end

template "#{node['incident_bot']['install_dir']}/package.json" do
  source 'package.json.erb'
  owner node['incident_bot']['user']
  group node['incident_bot']['group']
  mode '0644'
  variables node['incident_bot'].to_hash
  notifies :install, 'nodejs_npm[install]', :immediately
end

# Install everything in the package.json
nodejs_npm 'install' do
  path node['incident_bot']['install_dir']
  json true
  user node['incident_bot']['user']
  group node['incident_bot']['group']
  action :nothing
  notifies :restart, "#{daemon}_service[bot]", :delayed
end

# Enabled External Scripts
template "#{node['incident_bot']['install_dir']}/external-scripts.json" do
  source 'external-scripts.json.erb'
  owner node['incident_bot']['user']
  group node['incident_bot']['group']
  mode '0644'
  variables node['incident_bot'].to_hash
  notifies :restart, "#{daemon}_service[bot]", :delayed
end

include_recipe "incident_bot::_#{daemon}"
