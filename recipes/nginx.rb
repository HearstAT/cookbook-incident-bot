#
# Cookbook Name:: incident_bot
# Recipe:: apache
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
#
# Nginx config to setup ssl reverse proxy to hubot listener

include_recipe 'letsencrypt'

node.default['letsencrypt']['contact'] = node['incident_bot']['letsencrypt']['contact']
node.default['letsencrypt']['endpoint'] = node['incident_bot']['letsencrypt']['endpoint']

node.default['nginx']['default_site_enabled'] = false

include_recipe 'nginx'

directory "#{node['incident_bot']['install_dir']}/ssl" do
  owner node['incident_bot']['user']
  group node['incident_bot']['group']
  recursive true
  mode '0755'
end

template "#{node['nginx']['dir']}/sites-available/" <<
         node['incident_bot']['nginx']['site_name'] do
  source 'bot.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'service[nginx]'
end

template "#{node['nginx']['dir']}/index.html" do
  source 'index.html.erb'
    owner 'root'
    group 'root'
    mode 0755
end

nginx_site node['incident_bot']['nginx']['site_name'] do
  enable true
  timing :immediately
end

letsencrypt_certificate node['incident_bot']['endpoint'] do
  fullchain node['incident_bot']['nginx']['ssl']['crt_file']
  key node['incident_bot']['nginx']['ssl']['key_file']
  method 'http'
  wwwroot node['incident_bot']['install_dir']
  notifies  :reload, 'service[nginx]'
end
