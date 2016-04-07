require 'serverspec'
require 'pathname'

set :backend, :exec

set :path, '/bin:/sbin:/usr/sbin:/usr/bin:$PATH'
