echo 'Installing required puppet modules'
cd /vagrant
/opt/puppetlabs/puppet/bin/r10k puppetfile install > /dev/null # 2>&1

