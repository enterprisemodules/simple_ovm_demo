#
# Configure the puppet path's
#
echo 'Setting up Puppet module directories'
dirname=/etc/puppetlabs/code/environments/production/modules
if [ -d $dirname ]; then
  sudo rm -rf $dirname
else
  sudo rm -f $dirname
fi
sudo ln -sf /vagrant/modules /etc/puppetlabs/code/environments/production

echo 'Setting up Puppet manifest directories'
dirname=/etc/puppetlabs/code/environments/production/manifests
if [ -d $dirname ]; then
  sudo rm -rf $dirname
else
  sudo rm -f $dirname
fi
sudo ln -sf /vagrant/manifests /etc/puppetlabs/code/environments/production
