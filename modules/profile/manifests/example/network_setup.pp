# Base network setup
class profile::example::network_setup()
{
  ovm_network { 'default/192.168.56.0':
    ensure      => 'present',
    description => 'Test network',
    roles       => ['MANAGEMENT', 'CLUSTER_HEARTBEAT', 'LIVE_MIGRATE', 'VIRTUAL_MACHINE', 'STORAGE'],
  }
}
