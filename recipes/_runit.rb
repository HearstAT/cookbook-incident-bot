include_recipe 'runit'

runit_service 'bot' do
  options node['incident_bot'].to_hash
  env node['incident_bot']['config'].to_hash
  default_logger node['incident_bot']['runit']['default_logger']
end
