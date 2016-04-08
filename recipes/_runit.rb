include_recipe 'runit'

runit_service 'hubot' do
  options node['incident_bot'].to_hash
  env node['incident_bot']['config']
  default_logger node['incident_bot']['runit']['default_logger']
end
