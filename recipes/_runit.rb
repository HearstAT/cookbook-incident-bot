include_recipe 'runit'

node.default['incident_bot']['config']['HUBOT_SLACK_TOKEN'] = citadel['slack/api_key']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_USER_ID'] = citadel['pagerduty/user_id']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_SERVICE_API_KEY'] = citadel['pagerduty/service_key']
node.default['incident_bot']['config']['HUBOT_PAGERDUTY_USER_ID'] = citadel['pagerduty/user_id']

runit_service 'bot' do
  options node['incident_bot'].to_hash
  env node['incident_bot']['config'].to_hash
  default_logger node['incident_bot']['runit']['default_logger']
end
