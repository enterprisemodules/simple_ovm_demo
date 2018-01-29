#
# Example class for ovm_demo
#
class profile::example()
{
  contain ::profile::example::base_setup
  contain ::profile::example::storage_setup
  contain ::profile::example::network_setup
  contain ::profile::example::vms

  Class['::profile::example::base_setup']
  ->Class['::profile::example::storage_setup']
  ->Class['::profile::example::network_setup']
  ->Class['::profile::example::vms']
}
