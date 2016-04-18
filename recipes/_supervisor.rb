include_recipe 'supervisor'

node.default['incident_bot']['config']['HUBOT_SLACK_TOKEN'] = citadel['slack/api_key']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_USER_ID'] = citadel['pagerduty/user_id']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_API_KEY'] = citadel['pagerduty/api_key']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_SERVICE_API_KEY'] = citadel['pagerduty/service_key']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_USER_ID'] = citadel['pagerduty/user_id']

hubot_name = node['incident_bot']['name']
hubot_bin = File.join(node['incident_bot']['install_dir'], 'node_modules', '.bin', 'hubot')
hubot_adapter = node['incident_bot']['adapter']

node.default['incident_bot']['config']['PATH'] = "#{node['incident_bot']['install_dir']}/node_modules/.bin:%(ENV_PATH)s"

supervisor_service 'incident_bot' do
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
