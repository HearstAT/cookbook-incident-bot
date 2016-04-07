require 'spec_helper'

describe 'hubot' do

  it 'should have a hubot configuration file' do
    expect(file('/opt/hubot/config/hubot.conf')).to be_file
  end

  it 'should contain configured secret elements' do
    expect(file('/opt/hubot/config/hubot.conf')).to contain "HUBOT_PAGERDUTY_API_KEY='password'"
    expect(file('/opt/hubot/config/hubot.conf')).to contain "HUBOT_PAGERDUTY_SERVICE_API_KEY='password'"
    expect(file('/opt/hubot/config/hubot.conf')).to contain "HUBOT_SLACK_TOKEN='apikey'"
  end

  it 'should have json file for packages' do
    expect(file('/opt/hubot/external-scripts.json')).to be_file
  end
end
