name('test_bot')

description('This is a role for setting up hubot for a business unit')

run_list('recipe[incident_bot]')

default_attributes(
  incident_bot: {
    name: 'devbot'
  }
)
