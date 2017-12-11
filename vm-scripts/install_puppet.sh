#
# Install Puppet using yum
#
yum install -y --nogpgcheck https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm > /dev/null
yum install -y --nogpgchec puppet git > /dev/null # 2>&1
