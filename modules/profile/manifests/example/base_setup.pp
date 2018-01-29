#
# Base setup for the ovm_config demo
#
class profile::example::base_setup(
  String $password,
)
{
  ovm_manager { 'default':
    username    => 'admin',
    password    => $password,
    manager_url => 'https://ovmmgr.example.com',
    verify_ssl  => false,
    port        => 7002,
  }

  ovm_server_pool { 'default/server_pool_1':
    ensure          => 'present',
    description     => 'Server Pool Number 1',
    keymap          => 'en-us',
    virtual_ip      => '192.168.56.99',
    vm_start_policy => 'BEST_SERVER',
  }

  ovm_server { 'default/server_pool_1/ovs01.example.com':
    ensure     => 'present',
    ip_address => '192.168.56.2',
    password   => $password,
  }

}
