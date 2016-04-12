include_recipe 'supervisor'

hubot_name = node['incident_bot']['name']
hubot_bin = File.join(node['incident_bot']['install_dir'], 'node_modules', '.bin', 'hubot')
hubot_adapter = node['incident_bot']['adapter']

node.default['incident_bot']['config']['PATH'] = "#{node['incident_bot']['install_dir']}/node_modules/.bin:%(ENV_PATH)s"

supervisor_service 'incident-bot' do
  action [:enable, :start]
  autostart true
  autorestart true
  directory node['incident_bot']['install_dir']
  command "#{hubot_bin} -n \"#{hubot_name}\" -a #{hubot_adapter}"
  stopsignal 'TERM'
  user node['incident_bot']['user']
  startretries 3
  stdout_logfile node['incident_bot']['supervisor']['stdout_logfile']
  stdout_logfile_maxbytes node['incident_bot']['supervisor']['stdout_logfile_maxbytes']
  stdout_logfile_backups node['incident_bot']['supervisor']['stdout_logfile_backups']
  stderr_logfile node['incident_bot']['supervisor']['stderr_logfile']
  stderr_logfile_maxbytes node['incident_bot']['supervisor']['stderr_logfile_maxbytes']
  stderr_logfile_backups node['incident_bot']['supervisor']['stderr_logfile_backups']
  environment node['incident_bot']['config']
end
