name 'incident_bot'
maintainer 'Hearst Automation Team'
maintainer_email 'atat@hearst.com'
license 'All rights reserved'
description 'Installs/Configures the Hearst Incident Bot'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

supports 'ubuntu', '>= 10.04'

depends 'letsencrypt'
depends 'supervisor'
depends 'runit'
depends 'nodejs'
depends 'apt'
depends 'git'
depends 'chef-client'
depends 'citadel', '1.0.2'
