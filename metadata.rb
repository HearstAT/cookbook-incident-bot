name 'incident_bot'
maintainer 'Hearst Automation Team'
maintainer_email 'atat@hearst.com'
license 'All rights reserved'
description 'Installs/Configures incident_bot'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

supports 'ubuntu'

depends 'apache2'
depends 'nodejs'
depends 's3fs'
depends 'apt'
