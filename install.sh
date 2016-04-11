#!/bin/bash -x

# Install Chef
CHEFDIR=/var/chef/cookbooks

# Add chef repo
curl -s https://packagecloud.io/install/repositories/chef/stable/script.deb.sh | bash
apt-get update

# Install Chef
apt-get install -y chefdk

# setup cookbooks directory
sudo mkdir -p /var/chef/cookbooks
sudo chmod -R 777 /var/chef/cookbooks

# Copy over the cookbooks
CDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f ${CHEFDIR}/incident_bot

cat > "${CHEFDIR}/Berksfile" <<EOF
source 'https://supermarket.chef.io'
cookbook "incident_bot", path: "${CDIR}"
EOF

cd $CHEFDIR

# Install dependencies
berks vendor

# create client.rb file so that Chef client can find its dependant cookbooks
cat > "/var/chef/cookbooks/client.rb" <<EOF
cookbook_path File.join(Dir.pwd, 'berks-cookbooks')
EOF

# Run Chef
sudo chef-client -z -c "/var/chef/cookbooks/client.rb" -o incident_bot
